import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doclink/patient/common/common_fun.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/common/fancy_button.dart';
import 'package:doclink/patient/common/image_send_sheet.dart';
import 'package:doclink/patient/common/video_upload_dialog.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/chat/chat.dart';
import 'package:doclink/patient/model/doctor/fetch_doctor.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/services/api_service.dart';
import 'package:doclink/utils/const_res.dart';
import 'package:doclink/utils/extention.dart';
import 'package:doclink/utils/firebase_res.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MessageChatScreenController extends GetxController {
  TextEditingController msgController = TextEditingController();
  TextEditingController sendMediaController = TextEditingController();
  ScrollController scrollController = ScrollController();
  Conversation conversation = Conversation();
  RegistrationData userData = RegistrationData();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late DocumentReference documentSender;
  late DocumentReference documentReceiver;
  late CollectionReference drChatMessages;
  String firebaseUserIdentity = '';
  String firebaseDoctorIdentity = '';
  List<ChatMessage> chatData = [];
  String deletedId = '';
  ChatUser? receiverUser;
  ChatUser? senderUser;
  List<String> notDeletedIdentity = [];
  int startingNumber = 30;
  StreamSubscription<QuerySnapshot<ChatMessage>>? chatStream;
  bool isOpen = false;
  GlobalKey<FancyButtonState> key = GlobalKey<FancyButtonState>();
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;
  String? videoUrl;
  List<String> timeStamp = [];
  bool isLongPress = false;
  Doctor? doctor;
  static String senderId = '';

  @override
  void onInit() {
    conversation = Get.arguments[0];
    senderId = conversation.conversationId ?? '';
    userData = Get.arguments[1];
    fetchDoctorProfile();
    initFireBase();
    super.onInit();
  }

  void initFireBase() async {
    firebaseDoctorIdentity = conversation.user?.userIdentity ?? '';
    firebaseUserIdentity =
        '${FirebaseRes.pt}${'${userData.identity}'.removeUnUsed}';

    documentReceiver = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseDoctorIdentity)
        .collection(FirebaseRes.userList)
        .doc(firebaseUserIdentity);
    documentSender = db
        .collection(FirebaseRes.userChatList)
        .doc(firebaseUserIdentity)
        .collection(FirebaseRes.userList)
        .doc(firebaseDoctorIdentity);

    documentSender
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then(
      (value) async {
        chatData = [];
        if (value.data() != null && value.data()?.conversationId != null) {
          conversation.setConversationId(value.data()?.conversationId);
        }
        drChatMessages = db
            .collection(FirebaseRes.chat)
            .doc(conversation.conversationId)
            .collection(FirebaseRes.chat);
        getChat();
      },
    );
    onScrollToFetchData();
  }

  void onSendBtnTap() {
    if (msgController.text.isNotEmpty) {
      chatMessage(msgType: FirebaseRes.text, msg: msgController.text.trim());
      msgController.clear();
      update();
    }
  }

  void allScreenTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (key.currentState?.isOpened == true) {
      key.currentState?.animate();
    }
  }

  void onTextFiledTap() {
    if (key.currentState?.isOpened == true) {
      key.currentState?.animate();
    }
  }

  onScrollToFetchData() {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        getChat();
      }
    });
  }

  void getChat() async {
    await documentSender
        .withConverter(
          fromFirestore: Conversation.fromFirestore,
          toFirestore: (Conversation value, options) {
            return value.toFirestore();
          },
        )
        .get()
        .then((value) {
      if (value.data()?.user != null) {
        senderUser = value.data()?.user;
      }
      deletedId = value.data()?.deletedId.toString() ?? '';
    });

    chatStream = drChatMessages
        .where(FirebaseRes.noDeleteIdentity,
            arrayContains: firebaseUserIdentity)
        .where(FirebaseRes.id,
            isGreaterThan: deletedId.isEmpty ? '0' : deletedId)
        .orderBy(FirebaseRes.id, descending: true)
        .limit(startingNumber)
        .withConverter(
          fromFirestore: ChatMessage.fromFirestore,
          toFirestore: (ChatMessage value, options) {
            return value.toFirestore();
          },
        )
        .snapshots()
        .listen(
      (element) async {
        chatData = [];
        for (int i = 0; i < element.docs.length; i++) {
          chatData.add(element.docs[i].data());
        }
        startingNumber += 45;
        update();
      },
    );
  }

  /// long press to select chat method
  void onLongPress(ChatMessage? data) {
    if (!timeStamp.contains('${data?.id}')) {
      timeStamp.add('${data?.id}');
    } else {
      timeStamp.remove('${data?.id}');
    }
    isLongPress = true;
    update();
  }

  ///Firebase message update method
  Future<void> chatMessage(
      {required String msgType,
      String? msg,
      String? image,
      String? video}) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    notDeletedIdentity = [];
    notDeletedIdentity.addAll(
      [firebaseUserIdentity, firebaseDoctorIdentity],
    );
    drChatMessages.doc(time).set(
          ChatMessage(
            notDeletedIdentities: notDeletedIdentity,
            senderUser: ChatUser(
                username: userData.fullname,
                msgCount: 0,
                userid: userData.id,
                userIdentity: firebaseUserIdentity,
                image: userData.profileImage,
                age: userData.dob != null || userData.dob!.isNotEmpty
                    ? CommonFun.calculateAge(userData.dob).toString()
                    : null,
                gender:
                    userData.gender == 0 ? PS.current.female : PS.current.male),
            msgType: msgType,
            msg: msg,
            image: image,
            video: video,
            id: time,
          ).toJson(),
        );

    if (chatData.isEmpty && deletedId.isEmpty) {
      Map con = conversation.toJson();
      con[FirebaseRes.lastMsg] = msgType == FirebaseRes.image
          ? '🖼️ ${FirebaseRes.image}'
          : msgType == FirebaseRes.video
              ? '🎥 ${FirebaseRes.video}'
              : msg;
      documentSender.set(con);
      documentReceiver.set(
        Conversation(
          conversationId: conversation.conversationId,
          deletedId: '',
          isDeleted: false,
          lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          newMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          time: time,
          user: ChatUser(
              username: userData.fullname,
              msgCount: 1,
              userid: userData.id,
              userIdentity: firebaseUserIdentity,
              image: userData.profileImage,
              age: userData.dob != null || userData.dob!.isNotEmpty
                  ? CommonFun.calculateAge(userData.dob).toString()
                  : null,
              gender: userData.gender == 0 ? PS.current.female : PS.current.male),
        ).toJson(),
      );
    } else {
      await documentReceiver
          .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          )
          .get()
          .then((value) {
        receiverUser = value.data()?.user;
        receiverUser?.msgCount = (receiverUser?.msgCount ?? 0) + 1;

        documentReceiver.update({
          FirebaseRes.time: time,
          FirebaseRes.isDeleted: false,
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
          FirebaseRes.user: receiverUser?.toJson(),
        });
      });
      documentSender.update(
        {
          FirebaseRes.time: time,
          FirebaseRes.isDeleted: false,
          FirebaseRes.lastMsg: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : msg,
        },
      );
    }

    if (doctor?.isNotification == 1) {
      PatientApiService().pushNotification(
          authorization: ConstRes.authorisationKey,
          title: userData.fullname ?? PS.current.unKnown,
          body: msgType == FirebaseRes.image
              ? '🖼️ ${FirebaseRes.image}'
              : msgType == FirebaseRes.video
                  ? '🎥 ${FirebaseRes.video}'
                  : '$msg',
          token: '${doctor?.deviceToken}',
          senderIdentity: conversation.conversationId,
          notificationType: '0');
    }
  }

  void onImageTap({required ImageSource source}) async {
    key.currentState?.animate();
    final XFile? galleryImage = await _picker.pickImage(
        source: source,
        imageQuality: ConstRes.imageQuality,
        maxHeight: ConstRes.maxHeight,
        maxWidth: ConstRes.maxWidth);
    if (galleryImage != null) {
      PatientApiService.instance
          .uploadFileGivePath(File(galleryImage.path))
          .then((value) {
        imageUrl = value.path;
      });
      Get.bottomSheet(
              ImageSendSheet(
                image: galleryImage.path,
                onSendMediaTap: (image) =>
                    onSendMediaTap(image: galleryImage.path, type: 0),
                sendMediaController: sendMediaController,
              ),
              isScrollControlled: true)
          .then((value) {
        sendMediaController.clear();
      });
    }
  }

  void onVideoTap() async {
    key.currentState?.animate();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      /// calculating file size
      final videoFile = File(video.path);
      int sizeInBytes = videoFile.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);
      if (sizeInMb <= 15) {
        CustomUi.loader();
        PatientApiService.instance.uploadFileGivePath(File(video.path)).then((value) {
          videoUrl = value.path;
        });
        VideoThumbnail.thumbnailFile(video: video.path).then((value) {
          PatientApiService.instance
              .uploadFileGivePath(File(value ?? ''))
              .then((value) {
            imageUrl = value.path;
          });
          Get.back();
          Get.bottomSheet(
                  ImageSendSheet(
                    image: value ?? '',
                    onSendMediaTap: (String image) => onSendMediaTap(
                        image: value ?? '', type: 1, video: videoFile.path),
                    sendMediaController: sendMediaController,
                  ),
                  isScrollControlled: true)
              .then((value) {
            sendMediaController.clear();
          });
        });
      } else {
        showDialog(
          context: Get.context!,
          builder: (context) {
            return VideoUploadDialog(selectAnother: () {
              Get.back();
              onVideoTap();
            });
          },
        );
      }
    }
  }

  void onSendMediaTap(
      {required String image, required int type, String? video}) async {
    if (type == 0) {
      if (imageUrl == null) {
        await PatientApiService.instance.uploadFileGivePath(File(image)).then((value) {
          imageUrl = value.path;
        });
      }
      Get.back();
      chatMessage(
          msgType: FirebaseRes.image,
          msg: sendMediaController.text.trim(),
          image: imageUrl);
    } else {
      if (videoUrl == null) {
        await PatientApiService.instance
            .uploadFileGivePath(File(video ?? ''))
            .then((value) {
          videoUrl = value.path;
        });
      } else if (imageUrl == null) {
        await PatientApiService.instance.uploadFileGivePath(File(image)).then((value) {
          imageUrl = value.path;
        });
      }
      Get.back();
      chatMessage(
        msgType: FirebaseRes.video,
        msg: sendMediaController.text.trim(),
        image: imageUrl,
        video: videoUrl,
      );
    }
  }

  void onMsgDeleteBackTap() {
    timeStamp = [];
    update();
  }

  void onChatItemDelete() {
    for (int i = 0; i < timeStamp.length; i++) {
      drChatMessages.doc(timeStamp[i]).update(
        {
          FirebaseRes.noDeleteIdentity: FieldValue.arrayRemove(
            [firebaseUserIdentity],
          )
        },
      );
      chatData.removeWhere(
        (element) => element.id.toString() == timeStamp[i],
      );
    }
    timeStamp = [];
    Get.back();
    update();
  }

  void fetchDoctorProfile() async {
    PatientApiService.instance
        .fetchDoctorProfile(doctorId: conversation.user?.userid)
        .then((value) {
      doctor = value.data;
      update();
    });
  }

  Future<void> _msgCountUpdate() async {
    if (senderUser != null) {
      senderUser?.msgCount = 0;
      documentSender.update({FirebaseRes.user: senderUser?.toJson()});
    } else {
      await documentSender
          .withConverter(
            fromFirestore: Conversation.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          )
          .get()
          .then((value) {
        if (value.data()?.user != null) {
          senderUser = value.data()?.user;
          senderUser?.msgCount = 0;
          documentSender.update({FirebaseRes.user: senderUser?.toJson()});
        }
      });
    }
  }

  @override
  void onClose() async {
    senderId = '';
    await _msgCountUpdate();
    await chatStream?.cancel();
    msgController.dispose();
    sendMediaController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
