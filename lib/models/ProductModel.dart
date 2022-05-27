// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison, file_names

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));
String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
        required this.barcode,
        required this.rootcode,
        required this.pname,
        required this.md,
        required this.type,
        required this.status,
        required this.pog,
        required this.ot,
        required this.sp,
        required this.np,
        required this.boh,
        required this.bod,
        required this.pz,
        required this.p1,
        required this.sf,
        required this.bS,
    });

    String barcode;
    String rootcode;
    String pname;
    String md;
    String type;
    String status;
    String pog;
    String ot;
    String sp;
    String np;
    String boh;
    String bod;
    String pz;
    String p1;
    String sf;
    String bS;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        barcode: json["barcode"] == null ? null : json["barcode"],
        rootcode: json["rootcode"] == null ? null : json["rootcode"],
        pname: json["pname"] == null ? null : json["pname"],
        md: json["md"] == null ? null : json["md"],
        type: json["type"] == null ? null : json["type"],
        status: json["status"] == null ? null : json["status"],
        pog: json["pog"] == null ? null : json["pog"],
        ot: json["ot"] == null ? null : json["ot"],
        sp: json["sp"] == null ? null : json["sp"],
        np: json["np"] == null ? null : json["np"],
        boh: json["boh"] == null ? null : json["boh"],
        bod: json["bod"] == null ? null : json["bod"],
        pz: json["pz"] == null ? null : json["pz"],
        p1: json["p1"] == null ? null : json["p1"],
        sf: json["sf"] == null ? null : json["sf"],
        bS: json["b_s"] == null ? null : json["b_s"],
    );

    Map<String, dynamic> toJson() => {
        "barcode": barcode == null ? null : barcode,
        "rootcode": rootcode == null ? null : rootcode,
        "pname": pname == null ? null : pname,
        "md": md == null ? null : md,
        "type": type == null ? null : type,
        "status": status == null ? null : status,
        "pog": pog == null ? null : pog,
        "ot": ot == null ? null : ot,
        "sp": sp == null ? null : sp,
        "np": np == null ? null : np,
        "boh": boh == null ? null : boh,
        "bod": bod == null ? null : bod,
        "pz": pz == null ? null : pz,
        "p1": p1 == null ? null : p1,
        "sf": sf == null ? null : sf,
        "b_s": bS == null ? null : bS,
    };
}
