import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firebase = FirebaseFirestore.instance.collection('grocerydb').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: () => Navigator.pop(context),child: Icon(Icons.arrow_back_ios_new)),
        title: Center(child: Text('Grocery App')),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebase,
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
                  return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 173 / 300,
                  ),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 173.w,
                      height: 300.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1.w,
                            color: const Color(0xFFE2E2E2),
                          ),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x00000000),
                            blurRadius: 12,
                            offset: Offset(0, 6),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 170.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.docs[index]['itemImage'].toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['item'].toString(),
                                  style: TextStyle(
                                    color: const Color(0xFF181725),
                                    fontSize: 16,
                                    fontFamily: 'Gilroy-Bold',
                                    fontWeight: FontWeight.w400,
                                    height: 1.12,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['quantity'].toString(),
                                  style: TextStyle(
                                    color: const Color(0xFF7C7C7C),
                                    fontSize: 14,
                                    fontFamily: 'Gilroy-Medium',
                                    fontWeight: FontWeight.w400,
                                    height: 1.29,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data!.docs[index]['price'].toString(),
                                  style: TextStyle(
                                    color: const Color(0xFF181725),
                                    fontSize: 18,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                Container(
                                              width: 45.67,
                                              height: 45.67,
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFF53B175),
                                                shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                                                ),
                                              ),
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                }
                else{
                  return SizedBox();
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
