// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:p1label/components/checkbox_custom.dart';
import 'package:p1label/components/elevated_full_button.dart';
import 'package:p1label/components/textfield_custom.dart';
import 'package:p1label/services/api.dart';
import 'package:p1label/themes/colors.dart';
import 'package:p1label/utils/constants.dart';

class PrintQuickScreen extends StatefulWidget {
  const PrintQuickScreen({Key? key}) : super(key: key);

  @override
  State<PrintQuickScreen> createState() => _PrintQuickScreenState();
}

class _PrintQuickScreenState extends State<PrintQuickScreen> {
  bool ckSF = false;
  bool ckBS = true;

  final FocusNode _focusNode = FocusNode();

  // สร้างตัวแปรไว้รับคียร์ที่กด
  List<LogicalKeyboardKey> keys = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // สร้าง Object player
  final player = AudioCache();

  // Enter จัดเก็บ
  void saveLabel() {

    // เล่นไฟล์เสียง
    player.play('audio/retroclick.wav');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: blueColor,
        content: Text(
          'บันทึกรายการนี้แล้ว',
          textAlign: TextAlign.center,
        )));
  }

  // Shift + P สั่งพิมพ์
  void printLabel() {

    // เล่นไฟล์เสียง
    player.play('audio/camera.mp3');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: dartGreenColor,
        content: Text(
          'สั่งปริ้นรายการนี้แล้ว',
          textAlign: TextAlign.center,
        )));
  }

  // Shift + Q ฟังก์ชันกลับหน้า home
  void backtoHome() {

    // เล่นไฟล์เสียง
    player.play('audio/jumpcoint.wav');

    Navigator.pushNamed(context, '/home');
  }
  // shift + p = พิมพ์
  // enter = จัดเก็บ
  // shift + q = ออก

  List product = [];

  void scanProduct(barcode) async {
    // print(barcode);
    var data = await CallAPI().readProduct(barcode);
    // ฟิลเตอร์ barcode ที่รับเข้ามา
    setState(() {
      product = data.where((map) => map["barcode"] == barcode).toList();
    });
    inspect(product);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: (event) {
        final key = event.logicalKey; // ตัวแปรรับค่า key ที่กดเข้ามา
        if (event is RawKeyDownEvent) {
          // เช็คว่ามีการกด keys เดิมไปหรือยัง
          if (keys.contains(key)) return;

          // Enter จัดเก็บ
          if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
            print('You press enter');
            saveLabel();
          }

          // Shift + P พิมพ์
          if (event.isKeyPressed(LogicalKeyboardKey.f1) ||
              (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) &&
                  event.isKeyPressed(LogicalKeyboardKey.keyP))) {
            printLabel();
          }

          // Shift + Q ออก
          if (event.isKeyPressed(LogicalKeyboardKey.f4) ||
              (event.isKeyPressed(LogicalKeyboardKey.shiftLeft) &&
                  event.isKeyPressed(LogicalKeyboardKey.keyQ))) {
            backtoHome();
          }

          setState(() {
            keys.add(key);
          });
        } else {
          // ลบ key เดิมออกจาก list
          setState(() {
            keys.remove(key);
          });
        }
      },
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Bar:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSMALL))),
                            Expanded(
                              flex: 10,
                              child: TextFieldCustom(
                                  readOnly: false,
                                  initialValue: product.isEmpty
                                      ? ""
                                      : product[0]['barcode'],
                                  textInputType: TextInputType.number,
                                  obscureText: false,
                                  autofocus: true,
                                  size: 6,
                                  maxlenght: 13,
                                  bgColor: white_color,
                                  borderColor: darker_GrayColor,
                                  borderWidth: 1,
                                  borderRadius: 5,
                                  fontSize: TEXT_SIZE_XSMALL,
                                  fontWeight: FontWeight.bold,
                                  onFieldSubmitted: (val) {
                                    scanProduct(val);
                                  }),
                            ),
                            Expanded(
                              flex: 10,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['rootcode'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 2, child: Text("")),
                            Expanded(
                              flex: 20,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['pname'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("MD:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSMALL))),
                            Expanded(
                              flex: 12,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['md'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['type'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("ST:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSMALL))),
                            Expanded(
                              flex: 6,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['status'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['pog'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                textInputType: TextInputType.text,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['pb'],
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("SP:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSMALL))),
                            Expanded(
                              flex: 9,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['sp'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text("NP:",
                                      style:
                                          TextStyle(fontSize: TEXT_SIZE_XSMALL)),
                                )),
                            Expanded(
                              flex: 9,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['np'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("BOH:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSSMALL))),
                            Expanded(
                              flex: 9,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['boh'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: product.isNotEmpty &&
                                      int.parse(product[0]['boh'].toString()) >
                                          0
                                  ? inputBgColor
                                  : btnLogoutColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                                fontColor: product.isNotEmpty &&
                                      int.parse(product[0]['boh'].toString()) >
                                          0
                                  ? textColorPrimary
                                  : white_color,
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text("BOD:",
                                      style:
                                          TextStyle(fontSize: TEXT_SIZE_XSSMALL)),
                                )),
                            Expanded(
                              flex: 9,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['bod'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("PZ:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSMALL))),
                            Expanded(
                              flex: 9,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                textInputType: TextInputType.text,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['pz'],
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text("P1:",
                                      style:
                                          TextStyle(fontSize: TEXT_SIZE_XSMALL)),
                                )),
                            Expanded(
                              flex: 5,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: false,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['p1'],
                                textInputType: TextInputType.number,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: white_color,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: CheckboxCustom(
                                  name: 'SF',
                                  fontSize: TEXT_SIZE_XSMALL,
                                  borderRadius: 5,
                                  val: ckSF,
                                ))
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                flex: 4,
                                child: Text("บาร์ล่าสุด:",
                                    style:
                                        TextStyle(fontSize: TEXT_SIZE_XSSMALL))),
                            Expanded(
                              flex: 14,
                              child: TextFieldCustom(
                                key: UniqueKey(),
                                readOnly: true,
                                initialValue:
                                    product.isEmpty ? "" : product[0]['barcode'],
                                textInputType: TextInputType.text,
                                obscureText: false,
                                autofocus: false,
                                size: 6,
                                bgColor: inputBgColor,
                                borderColor: darker_GrayColor,
                                borderWidth: 1,
                                borderRadius: 5,
                                fontSize: TEXT_SIZE_XSMALL,
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: CheckboxCustom(
                                  name: 'B/S',
                                  fontSize: TEXT_SIZE_XSMALL,
                                  borderRadius: 5,
                                  val: ckBS,
                                ))
                          ],
                        )
                      ],
                    )),
      
                // Button
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
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
                        // _handleKeyEvent();
                      }
                    },
                  ),
                ),
      
                // Button Group
                Row(
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
                          onPressed: printLabel,
                          height: 30,
                          fontSize: TEXT_SIZE_SMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedFullButton(
                        name: 'จัดเก็บ',
                        icon: Icons.save_outlined,
                        iconColor: white_color,
                        iconSize: TEXT_SIZE_Medium,
                        textColor: white_color,
                        btnColor: Colors.purple,
                        onPressed: saveLabel,
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
                          onPressed: backtoHome,
                          height: 30,
                          fontSize: TEXT_SIZE_SMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
