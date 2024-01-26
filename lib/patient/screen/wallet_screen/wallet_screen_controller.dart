import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/model/user/registration.dart';
import 'package:doclink/patient/model/wallet/wallet_statement.dart';
import 'package:doclink/patient/screen/recharge_wallet_sheet/recharge_wallet_sheet.dart';
import 'package:doclink/patient/screen/withdraw_request_screen/withdraw_request_screen.dart';
import 'package:doclink/patient/services/api_service.dart';

class WalletScreenController extends GetxController {
  RegistrationData? userData;
  int? start = 0;
  List<WalletStatementData>? walletData;
  bool isLoading = false;
  ScrollController statementController = ScrollController();

  @override
  void onInit() {
    fetchPatientData();
    fetchWalletStatementDataApiCall();
    fetchScrollData();
    super.onInit();
  }

  void onAddBtnClick() {
    Get.bottomSheet(
      const RechargeWalletSheet(
        screenType: 1,
      ),
      isScrollControlled: true,
    ).then((value) {
      start = 0;
      fetchPatientData();
      fetchWalletStatementDataApiCall();
    });
  }

  void fetchPatientData() {
    PatientApiService.instance.fetchMyUserDetails().then((value) {
      userData = value.data;
      update();
    });
  }

  void fetchWalletStatementDataApiCall() {
    isLoading = true;
    PatientApiService.instance.fetchWalletStatement(start: start).then((value) {
      if (start == 0) {
        walletData = value.data;
      } else {
        walletData?.addAll(value.data!);
      }
      start = walletData?.length;
      isLoading = false;
      update();
    });
  }

  void onWithdrawTap(RegistrationData? data) {
    ((data?.wallet ?? 0) > 99)
        ? Get.to(() => const WithdrawRequestScreen(),
                arguments: data?.wallet ?? 0)
            ?.then((value) {
            start = 0;
            fetchPatientData();
            fetchWalletStatementDataApiCall();
          })
        : CustomUi.snackBar(
            message: PS.current.notEnoughBalanceToWithdraw,
            iconData: Icons.wallet_rounded);
  }

  void fetchScrollData() {
    statementController.addListener(
      () {
        if (statementController.offset ==
            statementController.position.maxScrollExtent) {
          if (!isLoading) {
            fetchWalletStatementDataApiCall();
          }
        }
      },
    );
  }
}
