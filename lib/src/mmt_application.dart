import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mmt_mobile/model/language_model.dart';
import 'package:mmt_mobile/model/login_response.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../model/employee.dart';
import '../model/number_series.dart';
import '../model/odoo_session.dart';
import '../model/product/product.dart';
import '../model/product/uom_lines.dart';
import 'package:collection/collection.dart';
import 'enum.dart';

class MMTApplication {
  // Server
  // static const String serverUrl = 'http://217.15.166.234:8069';

  static String serverUrl = '';
  static Employee? currentUser;
  static Company? selectedCompany;

  static List<String> databaseList = [];
  static String loginDatabase = 'htz_db';
  static Session? session;
  static List<LanguageModel?> languageList = [];
  static LoginResponse? loginResponse;

  static ValueNotifier<LanguageCode> languageNotifier =
      ValueNotifier(LanguageCode.eng);

  static int qtyDigit = loginResponse?.deviceId?.qtyDigit ?? 0;
  static int priceDigit = loginResponse?.deviceId?.priceDigit ?? 0;
  static late NumberSeries? generatedNoSeries = null;



  static UomLine? getReferenceUomLine(List<UomLine> uomLines) {
    return uomLines
        .firstWhereOrNull((uomLine) => uomLine.uomType == 'reference');
  }

  static String nestedUomChanger(double refTotalQty, List<UomLine> uomLines,
      {bool goNextLine = false}) {
    uomLines.sort((a, b) => b.ratio!.compareTo(a.ratio!));
    StringBuffer stringBuffer = StringBuffer();
    if (refTotalQty == 0)
      return '0 ${uomLines.isEmpty ? 'UOM' : uomLines.first.uomName}';
    for (UomLine uomLine in uomLines) {
      // print(uomLine.uomName);
      if (uomLine.uomType == 'bigger') {
        final currentUomQty = (refTotalQty / uomLine.ratio!).floor();
        // final changed = tempQty / currentUomQty;
        refTotalQty = (refTotalQty % uomLine.ratio!).roundToDouble();
        if (currentUomQty > 0)
          stringBuffer.write(
              '${_spacerAdd(stringBuffer, goNextLine)}${currentUomQty} ${uomLine.uomName}');
      } else if (uomLine.uomType == 'smaller') {
        final currentUomQty = (refTotalQty * uomLine.ratio!).floor();
        // final changed = tempQty * currentUomQty;
        refTotalQty = (refTotalQty % uomLine.ratio!).roundToDouble();
        if (currentUomQty > 0)
          stringBuffer.write(
              '${_spacerAdd(stringBuffer, goNextLine)}${currentUomQty} ${uomLine.uomName}');
      } else if (uomLine.uomType == 'reference') {
        final currentUomQty = (refTotalQty / uomLine.ratio!).floor();
        refTotalQty = (refTotalQty % uomLine.ratio!).roundToDouble();
        if (currentUomQty > 0)
          stringBuffer.write(
              '${_spacerAdd(stringBuffer, goNextLine)}${currentUomQty} ${uomLine.uomName}');
      }
    }
    return stringBuffer.toString();
  }

  static double uomQtyToRefTotal(UomLine uomLine, double quantity) {
    double totalQty = 0;
    if (uomLine.uomType == 'bigger') {
      totalQty = quantity * uomLine.ratio!;
    } else if (uomLine.uomType == 'smaller') {
      totalQty = quantity / uomLine.ratio!;
    } else if (uomLine.uomType == 'reference') {
      totalQty = quantity * uomLine.ratio!;
    }
    return totalQty;
  }

  static double refToUom(UomLine uomLine, double quantity) {
    double totalQty = 0;
    if (uomLine.uomType == 'bigger') {
      totalQty = quantity / uomLine.ratio!;
    } else if (uomLine.uomType == 'smaller') {
      totalQty = quantity * uomLine.ratio!;
    } else if (uomLine.uomType == 'reference') {
      totalQty = quantity / uomLine.ratio!;
    }
    return totalQty;
  }

  static String lBQtyLongFormChanger(
      {required Product product, required double refQty}) {
    // print(refQty);
    // print(product.uomLines?.length);
    if (refQty < 0) return '0/0';
    StringBuffer sb = StringBuffer();
    (product.uomLines ?? []).forEach((uomLine) {
      if (uomLine.uomId == product.boxUomId && uomLine.uomType == 'reference') {
        int bQty = refQty ~/ uomLine.ratio!;
        int lQty = (refQty % uomLine.ratio!).floor();
        sb.write(bQty);
        sb.write("/");
        sb.write(lQty);
      } else if (uomLine.uomId == product.boxUomId &&
          uomLine.uomType == "bigger") {
        int bQty = refQty ~/ uomLine.ratio!;
        int lQty = (refQty % uomLine.ratio!).floor();
        sb.write(bQty);
        sb.write("/");
        sb.write(lQty);
      } else if (uomLine.uomId == product.boxUomId &&
          uomLine.uomType == 'smaller') {
        sb.write(0);
        sb.write("/");
        double lQty = refQty.floor() * (uomLine.ratio ?? 1);
        sb.write(lQty);
      }
    });
    return sb.toString();
  }


  static String _spacerAdd(StringBuffer buffer, bool goNextLine) {
    return buffer.isEmpty ? '' : (goNextLine ? '\n' : ' ');
  }

  static UomLine? getBoxUomLine(Product product) {
    if ((product.uomLines ?? []).isNotEmpty) {
      return product.uomLines
          ?.firstWhereOrNull((element) => element.uomId == product.boxUomId);
    }
    return null;
  }

  static UomLine? getLUomLine(Product product) {
    if ((product.uomLines ?? []).isNotEmpty) {
      return product.uomLines
          ?.firstWhereOrNull((element) => element.uomId == product.looseUomId);
    }
    return null;
  }
}
