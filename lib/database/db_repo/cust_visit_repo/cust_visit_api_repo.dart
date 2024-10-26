import 'package:dio/dio.dart';

import '../../../api/base_api_repo.dart';
import '../../../model/cust_visit.dart';
import 'cust_visit_db_repo.dart';

class CustVisitApiRepo extends BaseApiRepo {
  final CustVisitDBRepo _custVisitDBRepo;

  CustVisitApiRepo() : _custVisitDBRepo = CustVisitDBRepo.instance;

  Future<bool> saveCustVisit(CustVisit custVisit) async {
    Response response = await postMethodCall(additionalPath: '/post/', params: {
      "name": "mscm_customer_visit",
      "value": [custVisit.toJson()]
    });

    // await ApiCall(ApiUtils.buildDio()).postMethodCall(
    //   path: '/post/',
    //   data: {
    //     "name": "save_customer_visit",
    //     "token": '${DateTime.now().millisecondsSinceEpoch}',
    //     "args": [
    //       {
    //         "name": "mscm_customer_visit",
    //         "value": [custVisit.toJson()]
    //       }
    //     ]
    //   },
    // );

    if (response.data != null) {
      int success = response.data['data'] != null ||
              response.data!['data'].toString().trim().isNotEmpty
          ? response.data['data']
          : 0;
      return success > 0;
    } else
      print('cust visit save return null');
    return false;
  }
}
