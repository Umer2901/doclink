import 'package:doclink/doctor/screen/dashboard_screen/widget/custom_animated_bottom_bar.dart';
import 'package:doclink/doctor/screen/profile_screen/profile_screen.dart';
import 'package:doclink/utils/color_res.dart';
import 'package:doclink/utils/asset_res.dart';
import 'package:flutter/material.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int currentIndex = 0; // Add currentIndex to track selected tab


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(210.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: AppBar(
              backgroundColor: ColorRes.havelockBlue,
              automaticallyImplyLeading: false, // Remove the back arrow
              toolbarHeight: 250,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 80.0, left: 10),
                child: Text(
                  'Hello, Emily',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.alarm,
                        color: Colors.white,
                        size: 25.0, // Adjust the icon size as needed
                      ),
                      onPressed: () {
                        // Add your onPressed functionality here
                      },
                    ),
                  ),
                ),
              ],
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    left: 15.0,
                    bottom: 35.0,
                    right: 15.0,
                    child: Container(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: 'Search for a doctor or clinic..',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find by Specialities',
                      style: TextStyle(
                          fontSize: 17,
                          color: ColorRes.battleshipGrey,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                          fontSize: 17,
                          color: ColorRes.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 175, // Set your desired width
                    height: 110, // Set your desired height
                    child: Card(
                      color: ColorRes.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Same border radius as the container
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(AssetRes.frame)),
                      ), // Replace 'frame.png' with your image asset


                    ),
                  ),
          SizedBox(
            width: 175, // Set your desired width
            height: 110, // Set your desired height
            child: Card(
              color: ColorRes.lightGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    15.0), // Same border radius as the container
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(AssetRes.star)),
              ),
            )
          )

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 175, // Set your desired width
                    height: 110, // Set your desired height
                    child: Card(
                      color: ColorRes.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Same border radius as the container
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(AssetRes.vector)),
                      ), // Replace 'frame.png' with your image asset
                    ),
                  ),
                  SizedBox(
                      width: 175, // Set your desired width
                      height: 110, // Set your desired height
                      child: Card(
                        color: ColorRes.lightGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.0), // Same border radius as the container
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(AssetRes.stethoscope, width: 50, height: 50,)),
                        ),
                      )
                  )

                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Status', style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.w700),),
                      SizedBox(width: 5,),
                      Text('Online', style: TextStyle(fontSize: 20,
                          color: ColorRes.mediumGreen,
                          fontWeight: FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => HomeScreenDetails()));
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                          AssetRes.rectangle, // Replace with the path to your image asset
                          fit: BoxFit.cover, // Adjust the fit mode as needed
                        ),
                        Positioned(
                          right: 0, // Adjust the right value to position the circle as needed
                          bottom: 0, // Adjust the bottom value to position the circle as needed
                          child: Container(
                            width: 37, // Adjust the width of the circle
                            height: 38, // Adjust the height of the circle
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,

                            ),
                            // You can add child widgets inside the circle container if needed
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              )

              

            ],
          ),
        ),
      ),
    );
  }
}

const bottomSheetStyle = TextStyle(fontSize: 13);