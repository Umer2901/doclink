import 'package:doclink/patient/screen/complete_registration_screen/medical_history_controller.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/font_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  bool isPregnant = false;
  bool isDoctor = false;
  bool isHospital = false;
  bool isClinic = false;
  TextEditingController prescribed = TextEditingController();
  TextEditingController stomach = TextEditingController();
  Map<String, dynamic> medical_history = {
    "Are you pregnant?" : "No",
    "Recieving treatment from a:" : "No",
    "Suffer from:" : [],
    "Other information" : ""
  };

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      child: GetBuilder<MedicalHistoryController>(
        init: MedicalHistoryController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,

              backgroundColor: Colors.grey[300],
              elevation: 0,
              centerTitle: true,
              title:  Text(
                'Medical History',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),

              iconTheme: IconThemeData(color: Colors.black), // Set the back arrow color to black

            ),
            body:  SingleChildScrollView(

              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),

                      Row(
                          children: [
                            Expanded(
                              child: Text('Are you pregnant?',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                               if(index == 0){
                                 medical_history['Are you pregnant?'] = "Yes";
                               }else{
                                medical_history['Are you pregnant?'] = "No";
                                }
                              },
                            ),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Text(
                          //     'Receiving treatment from a:',
                          //     style: TextStyle(
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),



                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       width: 90,
                          //       child: ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             isDoctor = true;
                          //             isHospital = false;
                          //             isClinic = false;
                          //             medical_history['Recieving treatment from a:'] = "Doctor";
                          //           });
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          //           primary: isDoctor ? Colors.blue : Colors.grey,
                          //         ),
                          //         child: Text(
                          //           'Doctor',
                          //           style: TextStyle(
                          //             color: isDoctor ? Colors.white : Colors.black,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 90,
                          //       child: ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             isDoctor = false;
                          //             isHospital = true;
                          //             isClinic = false;
                          //             medical_history['Recieving treatment from a:'] = "Hospital";
                          //           });
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          //           primary: isHospital ? Colors.blue : Colors.grey,
                          //         ),
                          //         child: Text(
                          //           'Hospital',
                          //           style: TextStyle(
                          //             color: isHospital ? Colors.white : Colors.black,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 90,
                          //       child: ElevatedButton(
                          //         onPressed: () {
                          //           setState(() {
                          //             isDoctor = false;
                          //             isHospital = false;
                          //             isClinic = true;
                          //             medical_history['Recieving treatment from a:'] = "Clinic";
                          //           });
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          //           primary: isClinic ? Colors.blue : Colors.grey,
                          //         ),
                          //         child: Text(
                          //           'Clinic',
                          //           style: TextStyle(
                          //             color: isClinic ? Colors.white : Colors.black,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )



                        ],
                      ),
                    //   SizedBox(height: 10,),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //      Text('Taking any priscribed medicines',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       )),
                    //      TextField(
                    //         textAlignVertical: TextAlignVertical.bottom,
                    //         decoration: InputDecoration(
                    //           hintText: 'Details',
                    //           alignLabelWithHint: true,
                    //         ),
                    //         maxLines: null,
                    //         controller: prescribed,
                    //       ),
                    //   ],
                    // ),
                      SizedBox(height: 5,),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text('Recieving Treatment from Doctor',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              labels: [
                                'Yes',
                                'No',
                              ],
                              onToggle: (index) {
                               if(index == 0){
                                 medical_history['Recieving treatment from a:'] = "Yes";
                               }else{
                                 medical_history['Recieving treatment from a:'] = "No";
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Allergies to any medicines',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              labels: [
                                'Yes',
                                'No',
                              ],
                              onToggle: (index) {
                               var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Allergies to any medicines")){
                                list.add("Allergies to any medicines");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Allergies to any medicines");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Hay Fever or eczema',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Hay Fever or eczema")){
                                list.add("Hay Fever or eczema");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Hay Fever or eczema");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Text('Heart Problems',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  onToggle: (index) {
                                    var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Heart Problems")){
                                list.add("Heart Problems");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Heart Problems");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Bronchitis, Asthma or chest condition',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                 var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Bronchitis, Asthma or chest condition")){
                                list.add("Bronchitis, Asthma or chest condition");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Bronchitis, Asthma or chest condition");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 5,),

                            Row(
                              children: [
                                Expanded(
                                  child: Text('Fainting attacks',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  onToggle: (index) {
                                    var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Fainting attacks")){
                                list.add("Fainting attacks");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Fainting attacks");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),
                        SizedBox(height: 5,),
                        Row(
                        
                          children: [
                            Expanded(
                              child: Text('Giddiness',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Giddiness")){
                                list.add("Giddiness");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Giddiness");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                            Row(
                            
                              children: [
                                Expanded(
                                  child: Text('Blackouts',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  onToggle: (index) {
                                    var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Blackouts")){
                                list.add("Blackouts");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Blackouts");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),




                        SizedBox(height: 5,),

                            Row(
                              children: [
                                Expanded(
                                  child: Text('Epilepsy',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  onToggle: (index) {
                                   var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Epilepsy")){
                                list.add("Epilepsy");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Epilepsy");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),
                        SizedBox(height: 5,),


                            Row(
                              children: [
                                Expanded(
                                  child: Text('Diabetes',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  onToggle: (index) {
                                    var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Diabetes")){
                                list.add("Diabetes");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Diabetes");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              
                              children: [
                                Expanded(
                                  child: Text('Arthritis',  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                ToggleSwitch(
                                  initialLabelIndex: 1,
                                  totalSwitches: 2,
                                  activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                                  labels: [
                                    'Yes',
                                    'No',
                                  ],
                                  onToggle: (index) {
                                    var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Arthritis")){
                                list.add("Arthritis");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Arthritis");
                                  medical_history['Suffer from:'] = list;
                                }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Bruising or persistent bleeding',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Bruising or persistent bleeding")){
                                list.add("Bruising or persistent bleeding");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Bruising or persistent bleeding");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),




                        SizedBox(height: 5,),

                        Row(
                          children: [
                            Expanded(
                              child: Text('Any infectious deseases.',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Any infectious deseases.")){
                                list.add("Any infectious deseases.");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Any infectious deseases.");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: Text('Stomach ulcer',  style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ToggleSwitch(
                              initialLabelIndex: 1,
                              totalSwitches: 2,
                              labels: [
                                'Yes',
                                'No',
                              ],
                              activeBgColor: [
                                    ColorRes.darkSkyBlue
                                  ],
                              onToggle: (index) {
                                var list = medical_history['Suffer from:'] as List;
                               if(index == 0){
                                if(!list.contains("Stomach ulcer")){
                                list.add("Stomach ulcer");
                                medical_history['Suffer from:'] = list;
                               }
                               }else{
                                  list.remove("Stomach ulcer");
                                  medical_history['Suffer from:'] = list;
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                      SizedBox(height: 20,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Other information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                          TextField(
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              hintText: 'Details',
                              alignLabelWithHint: true,
                            ),
                            controller: stomach,
                            maxLines: null,
                          ),
                        ],
                      ),
                    SizedBox(height: 20,),

                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MyHome()));
                          medical_history['Other information'] = stomach.text;
                          controller.onSubmitbtn(medical_history);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Adjust the radius as needed
                                ),
                                backgroundColor: ColorRes.havelockBlue),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorRes.white,
                                fontFamily: FontRes.bold,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      )
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