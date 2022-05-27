// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:p1label/components/elevated_full_button.dart';
import 'package:p1label/models/ProductModel.dart';
import 'package:p1label/services/api.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class PrintListScreen extends StatefulWidget {
  const PrintListScreen({Key? key}) : super(key: key);

  @override
  State<PrintListScreen> createState() => _PrintListScreenState();
}

class _PrintListScreenState extends State<PrintListScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: CrossScroll(
              verticalBar: CrossScrollBar(thickness: 5),
              horizontalBar: CrossScrollBar(thickness: 5),
              normalColor: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                      future: CallAPI().getAllProduct(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          // ถ้าโหลดข้อมูลไม่ได้ หรือมีข้อผิดพลาด
                          return const Center(
                            child: Text('มีข้อผิดพลาดในการโหลดข้อมูล'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          // ถ้าโหลดข้อมูลสำเร็จ
                          List<ProductModel> product = snapshot.data;
                          return DataTable(
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) => btnBgVerColor),
                            dataRowHeight: 32,
                            columnSpacing: 20,
                            headingRowHeight: 32,
                            // horizontalMargin: 20,
                            columns: [
                              DataColumn(
                                  label: Text('TYPE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TEXT_SIZE_SMALL))),
                              DataColumn(
                                  label: Text('BARCODE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TEXT_SIZE_SMALL))),
                              DataColumn(
                                  label: Text('CODE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TEXT_SIZE_SMALL))),
                              DataColumn(
                                  label: Text('Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TEXT_SIZE_SMALL))),
                              DataColumn(
                                  label: Text('MD',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: TEXT_SIZE_SMALL)))
                            ],
                            rows:
                                List<DataRow>.generate(product.length, (index) {
                              ProductModel model = product[index];
                              return DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (index % 2 == 0) {
                                      return Color.fromARGB(255, 210, 210, 210)
                                          .withOpacity(0.3);
                                    }
                                    return Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.3);
                                  }),
                                  cells: [
                                    DataCell(Text(model.type.toString())),
                                    DataCell(Text('8851123212021')),
                                    DataCell(Text('100572635')),
                                    DataCell(Text('BP เครื่องดื่ม M-150')),
                                    DataCell(Text('BP เครื่องดื่ม M-150'))
                                  ]);
                            }),
                          );
                        } else {
                          return const Center(
                            // ระหว่างที่กำหลังโหลดข้อมูล สามารถใส่ loading...
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedFullButton(
              icon: Icons.settings_outlined,
              iconColor: white_color,
              iconSize: TEXT_SIZE_Normal,
              name: 'กำหนดเครื่องพิมพ์ กดปุ่มนี้',
              fontSize: TEXT_SIZE_SMedium,
              height: 35,
              textColor: white_color,
              btnColor: primaryColor,
              onPressed: () {
                if (kDebugMode) {
                  print('Setting');
                }
              },
            ),
          ),

          // Button Group
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ElevatedFullButton(
                      name: 'พิมพ์',
                      icon: Icons.print_outlined,
                      iconColor: white_color,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: white_color,
                      btnColor: greenColor,
                      onPressed: () {},
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedFullButton(
                    name: 'ลบ',
                    icon: Icons.save_outlined,
                    iconColor: white_color,
                    iconSize: TEXT_SIZE_Medium,
                    textColor: white_color,
                    btnColor: redColor,
                    onPressed: () {},
                    height: 30,
                    fontSize: TEXT_SIZE_SMedium,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ElevatedFullButton(
                      name: 'ออก',
                      icon: Icons.exit_to_app,
                      iconColor: white_color,
                      iconSize: TEXT_SIZE_Medium,
                      textColor: white_color,
                      btnColor: Colors.grey,
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/home');
                      },
                      height: 30,
                      fontSize: TEXT_SIZE_SMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
