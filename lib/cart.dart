import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final firestore = FirebaseFirestore.instance.collection('CartDb').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cart')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 363.w,
                              height: 75.h,
                              child: Row(
                                          children: [
                                            Container(
                          width: 80.w,
                          height: 75.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data!.docs[index]['itemImage'].toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            snapshot.data!.docs[index]['item'].toString(),
                            style: TextStyle(
                              color: const Color(0xFF181725),
                              fontSize: 16.sp,
                              fontFamily: 'Gilroy-Bold',
                              fontWeight: FontWeight.w400,
                              height: 1.12,
                              letterSpacing: 0.10,
                            ),
                                                      ),
                          Text(
                            snapshot.data!.docs[index]['quantity'].toString(),
                            style: TextStyle(
                              color: const Color(0xFF7C7C7C),
                              fontSize: 14.sp,
                              fontFamily: 'Gilroy-Medium',
                              fontWeight: FontWeight.w400,
                              height: 1.29,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFE2E2E2),
                                      ),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                                        ),
                                  ),
                                ),
                              Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFE2E2E2),
                                      ),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                    snapshot.data!.docs[index]['value'].toString(),
                                    style: TextStyle(
                                      color: const Color(0xFF181725),
                                      fontSize: 18.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                                        ),
                                  ),
                                ),
                               Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: const Color(0xFFE2E2E2),
                                      ),
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.sp,
                                      fontFamily: 'Gilroy',
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                    ),
                                                        ),
                                  ),
                                ),
                                ],
                                
                              ),
                              SizedBox(
                                width: 70.w,
                              ),
                              Text(
                            snapshot.data!.docs[index]['price'].toString(),
                            style: TextStyle(
                              color: const Color(0xFF181725),
                              fontSize: 18.sp,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: 0.10,
                            ),
                          ),
                            ],
                          )
                          ],
                        )
                                          ],
                              ),
                        ),
                      );
                    },);
                  }
                  else {
                    return SizedBox();
                  }
                }
              ))
          ],
        ),
      
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
                  width: 364.w,
                  height: 40.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF53B175),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Go to Checkout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFFFF9FF),
                        fontSize: 18.sp,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}