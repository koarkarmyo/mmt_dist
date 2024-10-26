
import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../../model/cust_visit.dart';
import '../../database_helper.dart';
import '../../db_constant.dart';

class CustVisitDBRepo extends BaseDBRepo {
  static final CustVisitDBRepo instance = CustVisitDBRepo._();

  CustVisitDBRepo._();

  Future<bool> saveCustVisit(CustVisit custVisit) async {
    return dataObject.insertCustVisit(custVisit);
  }

  Future<bool> updateUploaded(CustVisit custVisit) async {
    final CustVisit cust = custVisit.copyWith(isUpload: 1);
    return DatabaseHelper.instance.updateData(
        table: DBConstant.custVisitTable,
        where: '${DBConstant.customerId} = ? AND ${DBConstant.docDate} = ?',
        whereArgs: [custVisit.customerId, custVisit.docDate],
        data: cust.toJson());
  }

  Future<CustVisit?> getLastCustVisit() async {
    return await dataObject.getLastClockInOutProcess();
  }

  Future<List<CustVisit>> getCustVisitedListByDateAndCust(
      {required String name, String? startDate, String? endDate}) async {
    List<CustVisit> _custVisitList = [];

    String custQuery = '%';
    if (name != '') {
      custQuery = name;
    }

    String dateRangeQuery = '';
    if (startDate != null && endDate != null) {
      dateRangeQuery =
          'AND (${DBConstant.docDate} BETWEEN \'$startDate\' AND \'$endDate\')';
    }

    List<Map<String, dynamic>> _jsonList = await DatabaseHelper.instance
        .readDataRaw('''SELECT * FROM ${DBConstant.custVisitTable} WHERE
      ${DBConstant.customerName} LIKE \'%$custQuery%\' $dateRangeQuery
    ''');

    _jsonList.forEach((json) {
      _custVisitList.add(CustVisit.fromJson(json));
    });

    return _custVisitList;
  }

  Future<List<CustVisit>> getDraftCustVisitList() async {
    List<CustVisit> _custVisitList = [];
    List<Map<String, dynamic>> _jsonList = await DatabaseHelper.instance.readDataRaw('''
    SELECT * FROM ${DBConstant.custVisitTable} WHERE ${DBConstant.isUpload} == 0''');
    if (_jsonList.isNotEmpty) {
      _jsonList.forEach((json) {
        _custVisitList.add(CustVisit.fromJson(json));
      });
    }

    return _custVisitList;
  }

  Future<List<Map<String, dynamic>>> getCustVisitWitInOutTime(
      {required String start,
      required String endDate,
      String? custName}) async {
    List<Map<String, dynamic>> retJson = [];
    if (custName != null) {
      custName = '\"%$custName%\"';
    } else {
      custName = '\"%\"';
    }
    List<Map<String, dynamic>> custVisit = await DatabaseHelper.instance.readDataRaw(
        'SELECT DISTINCT * FROM ${DBConstant.custVisitTable} WHERE ${DBConstant.docDate} between \"$start\" AND \"$endDate\" '
        'AND ${DBConstant.docType} = \"${CustVisitTypes.clock_in.name}\" '
        'AND ${DBConstant.customerName} LIKE $custName GROUP by customer_id ORDER By ${DBConstant.docType} DESC');

    await Future.forEach<Map<String, dynamic>>(custVisit, (element) async {
      int custId = element['customer_id'];
      final jsonList = await DatabaseHelper.instance.readDataRaw(
          '''select S.customer_id, S.customer_name, S.doc_type, S.doc_date in_time, S.latitude in_latitude, S.longitude in_longitude, E.doc_type,
E.doc_date out_time, E.latitude out_latitude, E.longitude out_longitude
 from (
select ROW_NUMBER () OVER ( 
        PARTITION BY start.customer_id
        ORDER BY start.doc_type, start.doc_date
    ) RowNum,
start.customer_id, start.customer_name, start.doc_type,start.doc_date, start.latitude, start.longitude
 from cust_visits start
where start.doc_date between "$start" AND "$endDate" 
AND start.customer_id = $custId and start.doc_type = 'clock_in') as S
inner join 
 (
select ROW_NUMBER () OVER ( 
        PARTITION BY start.customer_id
        ORDER BY start.doc_type, start.doc_date
    ) RowNum,
start.customer_id, start.customer_name, start.doc_type,start.doc_date, start.latitude, start.longitude
 from cust_visits start
where start.doc_date between "$start" AND "$endDate" 
AND start.customer_id = $custId and start.doc_type = 'clock_out') as E
on S.customer_id = E.customer_id and S.RowNum = E.RowNum''');
      retJson.addAll(jsonList);
    });
    return retJson;
  }
}
