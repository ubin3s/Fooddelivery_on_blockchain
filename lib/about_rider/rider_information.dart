// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectfood/about_rider/rider.dart';
import 'package:projectfood/about_rider/rider_account_information.dart';
import 'package:projectfood/about_rider/rider_edit_information.dart';
import 'package:projectfood/about_rider/rider_home.dart';
import 'package:projectfood/main.dart';
import 'package:projectfood/widgets/customshape.dart';

// ignore: use_key_in_widget_constructors
class RiderInfo extends StatefulWidget {
  @override
  _RiderInfoState createState() => _RiderInfoState();
}

class _RiderInfoState extends State<RiderInfo> {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 37, 37, 1),
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromRGBO(255, 191, 64, 1),
        toolbarHeight: 80,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) {
              return RiderHome();
            }));
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: const Text("ข้อมูลส่วนตัว",
              style: TextStyle(fontFamily: 'NotoSansThai-Medium')),
          width: 165,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(118, 115, 217, 1),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Riders")
            .where("rider_id", isEqualTo: firebaseUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            color: Colors.white,
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return Column(
                  children: [
                    Container(
                      child: ClipPath(
                        clipper: Customshape(),
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.elliptical(
                                      MediaQuery.of(context).size.width, 100)),
                              color: const Color.fromRGBO(37, 37, 37, 1)),
                          child: SingleChildScrollView(
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return RiderEditInfo(
                                        riderId: document["rider_id"],
                                        riderName: document["rider_name"],
                                        riderCarModel:
                                            document["rider_car_model"],
                                        riderTel: document["rider_tel"],
                                        riderlicensePlate:
                                            document["rider_license_plate"]);
                                  }));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, top: 10),
                                            width: 80,
                                            child: Image.asset(
                                              "images/profile.png",
                                              width: 50,
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        document["rider_name"],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'NotoSansThai-Regular',
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            child: Text(
                                                              document[
                                                                  "rider_car_model"],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'NotoSansThai-Regular',
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 4),
                                                            child: Text(
                                                              document[
                                                                  "rider_license_plate"],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'NotoSansThai-Regular',
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: SizedBox(
                                                        width: 270,
                                                        height: 2,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsets.only(
                                      //       top: 20, left: 10),
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       ElevatedButton(
                                      //           onPressed: () {
                                      //             Navigator.push(context,
                                      //                 MaterialPageRoute(
                                      //                     builder: (context) {
                                      //               return RiderEditInfo(
                                      //                   riderId: document[
                                      //                       "rider_id"],
                                      //                   riderName: document[
                                      //                       "rider_name"],
                                      //                   riderCarModel: document[
                                      //                       "rider_car_model"],
                                      //                   riderTel: document[
                                      //                       "rider_tel"],
                                      //                   riderlicensePlate: document[
                                      //                       "rider_license_plate"]);
                                      //             }));
                                      //           },
                                      //           child:
                                      //               const Text("แก้ไขข้อมูล"))
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return RiderAccountInfo(
                                digitalWallet: document["digital_wallet"],
                                privateWallet:
                                    document["private_digital_wallet"],
                              );
                            }));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.assignment_ind_rounded,
                                size: 35,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "บัญชี",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'NotoSansThai-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 370,
                        height: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(233, 233, 233, 1)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.assignment,
                                size: 35,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "ประวัติการสั่งซื้อ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'NotoSansThai-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 370,
                        height: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(233, 233, 233, 1)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            auth.signOut().then((value) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return const Rider();
                              }));
                            });
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.logout,
                                size: 35,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "ออกจากระบบ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'NotoSansThai-Regular'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 370,
                        height: 1,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(233, 233, 233, 1)),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
