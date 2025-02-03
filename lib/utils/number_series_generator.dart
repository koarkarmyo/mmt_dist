import 'package:mmt_mobile/database/database_helper.dart';

import '../database/data_object.dart';
import '../database/db_constant.dart';
import '../exception/require_obj_missing_exception.dart';
import '../model/number_series.dart';
import '../src/enum.dart';
import '../src/mmt_application.dart';

class NoSeriesGenerator {
  static Future<String> generateNoSeries(
      {required NoSeriesDocType docType}) async {
    NumberSeries? noSeries =
        await DataObject.instance.getNumberSeries(moduleName: docType.name);
    StringBuffer stringBuffer = StringBuffer();
    DateTime currentDate = DateTime.now();
    int yearTwoDigit = int.parse(currentDate.year.toString().substring(2, 4));
    if (noSeries == null) {
      throw RequireObjMissingException(message: 'Number series missing error');
    }
    if (noSeries.resetIn == 'd') {
      if ((noSeries.yearLast ?? 0) != yearTwoDigit) {
        noSeries.numberLast = 0;
      }
      if ((noSeries.monthLast ?? 0) != currentDate.month) {
        noSeries.numberLast = 0;
      }
      if ((noSeries.dayLast ?? 0) != currentDate.day) {
        noSeries.numberLast = 0;
      }
    } else if (noSeries.resetIn == 'm') {
      if (noSeries.yearLast! != yearTwoDigit) {
        noSeries.numberLast = 0;
      }
      if (noSeries.monthLast! != currentDate.month) {
        noSeries.numberLast = 0;
      }
    } else if (noSeries.resetIn == 'y') {
      if (noSeries.yearLast! != yearTwoDigit) {
        noSeries.numberLast = 0;
      }
    }

    String prefix = noSeries.prefix!;
    stringBuffer.write(prefix);
    noSeries.yearLast = yearTwoDigit;
    noSeries.monthLast = currentDate.month;
    noSeries.dayLast = currentDate.day;

    if (noSeries.useYear!) {
      // String lastSegYear = currentDate.year.toString().substring(2, 4);
      // stringBuffer.write(lastSegYear);
      stringBuffer.write(noSeries.yearLast.toString());
    }
    if (noSeries.useMonth!) {
      // String lastSegMonth = currentDate.month.toString();
      String lastSegMonth = noSeries.monthLast.toString();
      if (lastSegMonth.length == 1) {
        lastSegMonth = lastSegMonth.padLeft(2, '0');
      }
      stringBuffer.write(lastSegMonth);
    }

    if (noSeries.useDay!) {
      // String lastSegDay = currentDate.day.toString();
      String lastSegDay = noSeries.dayLast.toString();
      if (lastSegDay.length == 1) {
        lastSegDay = lastSegDay.padLeft(2, '0');
      }
      stringBuffer.write(lastSegDay);
    }
    noSeries.numberLast = noSeries.numberLast! + 1;
    final temp = '${stringBuffer.toString()}${noSeries.numberLast}';

    if (temp.length <= noSeries.numberLength!) {
      int padLength = (noSeries.numberLength! - temp.length);
      String extraZero = ''.padRight(padLength, '0');
      stringBuffer.write(extraZero);
      stringBuffer.write(noSeries.numberLast!);
    }

    MMTApplication.generatedNoSeries = noSeries;
    await updateNoSeries(docType);
    final isDuplicated =
        await _checkDuplicatedNoSeries(docType, stringBuffer.toString());
    if (isDuplicated) {
      await updateNoSeries(docType);
      return await generateNoSeries(docType: docType);
    }
    return stringBuffer.toString();
  }

  static Future<bool> updateNoSeries(NoSeriesDocType type) async {
    /* Update Number Series After Local Save*/
    return await DatabaseHelper.instance.updateData(
        table: DBConstant.numberSeriesTable,
        where: '${DBConstant.name} =?',
        whereArgs: [
          type.name
        ],
        data: {
          DBConstant.numberLast: MMTApplication.generatedNoSeries!.numberLast,
          DBConstant.yearLast: MMTApplication.generatedNoSeries!.yearLast,
          DBConstant.monthLast: MMTApplication.generatedNoSeries!.monthLast,
          DBConstant.dayLast: MMTApplication.generatedNoSeries!.dayLast,
        });
  }

  static Future<String> generateTLDNoSeries() async {
    NumberSeries? noSeries = NumberSeries();
    // await DataObject.instance.getNumberSeries(moduleName: docType.name);

    StringBuffer sb = StringBuffer();
    DateTime currentDate = DateTime.now();
    int yearTwoDigit = int.parse(currentDate.year.toString().substring(2, 4));
    String currentMonth = currentDate.month.toString();
    if (currentMonth.length == 1) {
      currentMonth = currentMonth.padLeft(2, '0');
    }
    String currentDay = currentDate.day.toString();
    if (currentDay.length == 1) {
      currentDay = currentDay.padLeft(2, '0');
    }
    sb.write(noSeries.prefix);
    sb.write(yearTwoDigit);
    sb.write(currentMonth);
    sb.write(currentDay);

    noSeries.numberLast = noSeries.numberLast! + 1;
    final temp = '${sb.toString()}${noSeries.numberLast}';
    if (temp.length <= noSeries.numberLength!) {
      int padLength = (noSeries.numberLength! - temp.length);
      String extraZero = ''.padRight(padLength, '0');
      sb.write(extraZero);
      sb.write(noSeries.numberLast!);
    }
    MMTApplication.generatedNoSeries = noSeries;
    return sb.toString();
  }

  static Future<bool> _checkDuplicatedNoSeries(
      NoSeriesDocType docType, String genNo) async {
    DatabaseHelper sqlFLiteHelper = DatabaseHelper.instance;
    switch (docType) {
      case NoSeriesDocType.order:
        final list = await sqlFLiteHelper.readDataByWhereArgs(
            tableName: DBConstant.saleOrderTable,
            where: '${DBConstant.name} =?',
            whereArgs: [genNo]);
        return list.isNotEmpty;
      case NoSeriesDocType.loading:
        final list = await sqlFLiteHelper.readDataByWhereArgs(
            tableName: DBConstant.stockMoveTable,
            where: '${DBConstant.moveNo} =?',
            whereArgs: [genNo]);
        return list.isNotEmpty;
      case NoSeriesDocType.delivery:
        final list = await sqlFLiteHelper.readDataByWhereArgs(
            tableName: DBConstant.stockMoveTable,
            where: '${DBConstant.moveNo} =?',
            whereArgs: [genNo]);
        return list.isNotEmpty;
      // case NoSeriesDocType.delivery:
      //   final list = await sqlFLiteHelper.readDataByWhereArgs(
      //       tableName: DBConstant.stockMoveTable,
      //       where: '${DBConstant.moveNo} =?',
      //       whereArgs: [genNo]);
      //   return list.isNotEmpty;
      case NoSeriesDocType.stock_order:
        final list = await sqlFLiteHelper.readDataByWhereArgs(
            tableName: DBConstant.stockOrderTable,
            where: '${DBConstant.name} =?',
            whereArgs: [genNo]);
        return list.isNotEmpty;
      //
      case NoSeriesDocType.unloading:
        return true;
    }
  }
}
