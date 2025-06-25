import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Description extends StatefulWidget {
  final String item;
  final String itemImage;
  final String description;
  final String quantity;
  final String price;

  const Description({
    super.key,
    required this.item,
    required this.itemImage,
    required this.description,
    required this.quantity,
    required this.price,
  });

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  int value = 1;
  final ref = FirebaseFirestore.instance.collection('CartDb');
  void _incrementValue(){
    setState(() {
      value++;
    });
  }
  void _decrementValue(){
    setState(() {
      if (value > 0) {
        value--;
      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 413.w,
              height: 300.h,
              decoration: ShapeDecoration(
                // color: const Color(0xFFF2F3F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                ),
              ),
              child: Image.network(widget.itemImage),
            ),
            Text(
              widget.item,
              style: TextStyle(
                color: const Color(0xFF181725),
                fontSize: 24.sp,
                fontFamily: 'Gilroy-Bold',
                fontWeight: FontWeight.w400,
                height: 0.75,
                letterSpacing: 0.10,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              widget.quantity,
              style: TextStyle(
                color: const Color(0xFF7C7C7C),
                fontSize: 16.sp,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                height: 1.12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _decrementValue(),
                        child: Container(
                          width: 45.w,
                          height: 45.h,
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
                      ),
                      Container(
                        width: 45.w,
                        height: 45.h,
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
                            value.toString(),
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
                      GestureDetector(
                        onTap: () => _incrementValue(),
                        child: Container(
                          width: 45.w,
                          height: 45.h,
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
                      ),
                    ],
                  ),
                  Text(
                    widget.price,
                    style: TextStyle(
                      color: const Color(0xFF181725),
                      fontSize: 24.sp,
                      fontFamily: 'Gilroy-Bold',
                      fontWeight: FontWeight.w400,
                      height: 0.75,
                      letterSpacing: 0.10,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Detail',
                    style: TextStyle(
                      color: const Color(0xFF181725),
                      fontSize: 16.sp,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                      height: 1.12,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description,
                style: TextStyle(
                  color: const Color(0xFF7C7C7C),
                  fontSize: 13.sp,
                  fontFamily: 'Gilroy-Medium',
                  fontWeight: FontWeight.w400,
                  height: 1.62,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                ref.doc(id).set({
                  'id':id,
                  'item':widget.item,
                  'itemImage':widget.itemImage,
                  'price':widget.price,
                  'quantity':widget.quantity,
                  'value':value
                });
              },
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
                    'Add To Basket',
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
          ],
        ),
      ),
    );
  }
}
