import 'package:doclink/patient/common/custom_ui.dart';
import 'package:doclink/patient/generated/l10n.dart';
import 'package:doclink/patient/screen/findDoctor/find_doctor_controller.dart';
import 'package:doclink/patient/screen/home_screen/home_screen_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

class findDoctor extends StatefulWidget {
  const findDoctor({super.key});

  @override
  State<findDoctor> createState() => _findDoctorState();
}

class _findDoctorState extends State<findDoctor> {
  List<bool> isSelectedList = [false, false, false, false];
  List<bool> isSelectedList1 = [false, false, false, false];
  List<bool> isSelectedList2 = [false, false, false, false];

  List<String> selectedSpecializations = []; 
  TextEditingController _textEditingController = TextEditingController();
  List symptomsList = [
                            'Abdominal pain',
                            'Blood in stool',
                            'Heart Problems',
                            'Chest pain' ,
                            'Constipation' ,
                            'Cough', 
                             'Diarrhea',
                            'Dificulty in swallowing',
                            'Dizziness',
                            'Eye discomfort',
                            'Foot pain',
                            'Foot swelling',
                            'Headaches',
                            'Heart palpitation',
                            'Hip pain',
                            'Lower back pain',
                            'Nasal congestion',
                            'Nauseous or vomiting',
                            'Neckpain',
                            'tingling in hands',
                            'pelvic pain',
                            'shortness of breath',
                            'shoulder pain',
                            'sore throat',
                            'Urinary problems'
                          ];
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final homecontroller = Get.put(HomeScreenController());
     symptomsList.sort();
    return SafeArea(
      child: GetBuilder<FindDoctorController>(
        init: FindDoctorController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height * 1.1, // Set an explicit height
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0, // Position AppBar at the top
                            left: 0,
                            right: 0,
                            child: AppBar(
                              backgroundColor: ColorRes.havelockBlue,
                              toolbarHeight: 150,
                              automaticallyImplyLeading:
                                  false, // Remove the back arrow
                              title: Text(
                                'FIND DOCTOR',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              centerTitle: true, // Center the title within the total height
                            ),
                          ),
                          Positioned(
                            top: 120.0, // Adjust the top position to move the container below the AppBar
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Container background color
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30.0),
                                  topLeft: Radius.circular(30.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      // Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(left: 8.0),
                                      //     child: Text(
                                      //       'Detail',
                                      //       style: TextStyle(
                                      //           fontSize: 20,
                                      //           color: ColorRes.black,
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Container(
                                      //   height: 150.0,
                                      //   decoration: BoxDecoration(
                                      //       border: Border.all(color: Colors.grey),
                                      //       borderRadius:
                                      //           BorderRadius.circular(12)),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(8.0),
                                      //     child: TextField(
                                      //       controller: _textEditingController,
                                      //       maxLines:
                                      //           null, // Allow multiple lines of text
                                      //       decoration: InputDecoration(
                                      //         border: InputBorder.none,
                                      //         hintText: 'Enter your text here',
                                      //       ),
                                      //       style: TextStyle(
                                      //           fontSize: 16.0,
                                      //           color: Colors.black),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Symptoms',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorRes.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //   MainAxisAlignment.spaceEvenly,
                                      //   children: List.generate(
                                      //     isSelectedList.length,
                                      //     (index) => SizedBox(
                                      //       width: 75,
                                      //       child: ElevatedButton(
                                      //         onPressed: () {
                                      //           setState(() {
                                      //             isSelectedList[index] =
                                      //                 !isSelectedList[
                                      //                     index]; // Toggle the selected state
                                      //           });
                                      //         },
                                      //         style: ElevatedButton.styleFrom(
                                      //             shape: RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(20),
                                      //               side: BorderSide(
                                      //                 color: isSelectedList[index]
                                      //                     ? Colors.transparent
                                      //                     : Colors
                                      //                         .grey, // Border color when selected or unselected
                                      //               ),
                                      //             ),
                                      //             backgroundColor:
                                      //                 isSelectedList[index]
                                      //                     ? ColorRes.havelockBlue
                                      //                     : Colors.transparent,
                                      //             elevation:
                                      //                 0 // Background color when selected or unselected
                                      //             ),
                                      //         child: Text(
                                      //           'Fever',
                                      //           style: TextStyle(
                                      //             color: isSelectedList[index]
                                      //                 ? Colors.white
                                      //                 : Colors
                                      //                     .grey, // Text color when selected or unselected
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                   height: 50,
                      width: double.infinity,
                      color: const Color.fromRGBO(244, 244, 244, 1),
                  child: DropDownMultiSelect(
                          options: symptomsList, 
                          selectedValues: [
                          ], 
                          onChanged: (value){
                            controller.patient_symptoms = value;
                          },
                            decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: PS.current.enterHere,
                                  hintStyle: MyTextStyle.montserratMedium(
                                    size: 15,
                                    color: ColorRes.grey.withOpacity(0.7),
                                  ),
                                ),
                                
                                hintStyle: MyTextStyle.montserratMedium(
                                  size: 15,
                                  color: ColorRes.battleshipGrey,
                                ),
                          ),
                ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Specialization',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: ColorRes.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                                                    Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: GetBuilder(
                                  init: homecontroller,
                                  builder: (controller) {
                                    return GridView.builder(
                                      itemCount: controller.categories?.length,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        childAspectRatio: 3
                                      ), 
                                      itemBuilder: (context, index) {
                                        print(controller.categories?.length);
                                        return SizedBox(
                                          child:ElevatedButton(
  onPressed: () {
    controller.selectCategory(index);
    print(index);
  },
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: controller.index == index ? Colors.transparent : Colors.grey,
      ),
    ),
    backgroundColor: controller.index == index ? ColorRes.havelockBlue : Colors.transparent,
    elevation: 0,
  ),
  child: LayoutBuilder(
    builder: (context, constraints) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          controller.categories![index].title.toString(),
          style: TextStyle(
            fontSize: constraints.maxWidth > 150 ? 14 : 14, // Adjust font size based on available space
            color: controller.index == index ? ColorRes.white : Colors.grey,
          ),
        ),
      );
    },
  ),
),

                                        );
                                      },
                                      );
                                  }
                                ),
                              ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Payment will be deducted after call.',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: ColorRes.havelockBlue,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: SizedBox(
                                              height: 50,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                  onPressed: ()async{
                                                   int? id = homecontroller.categories![homecontroller.index].id;
                                                   controller.finddoctor(id);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0), // Adjust the radius as needed
                                                      ),
                                                      backgroundColor:
                                                          ColorRes.havelockBlue),
                                                  child: Text(
                                                    'Find a Doctor',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: ColorRes.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
