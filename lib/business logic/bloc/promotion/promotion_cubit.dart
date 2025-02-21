import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../database/database_helper.dart';
import '../../../database/db_constant.dart';
import '../../../model/promotion.dart';
import '../../../src/mmt_application.dart';
import '../../../utils/date_time_utils.dart';
import '../bloc_crud_process_state.dart';

part 'promotion_state.dart';

class PromotionCubit extends Cubit<PromotionState> {
  final DatabaseHelper _helper = DatabaseHelper.instance;

  PromotionCubit()
      : super(PromotionState(
          promotions: [],
          state: BlocCRUDProcessState.initial,
        ));

  fetchPromotions() async {
    emit(state.copyWith(state: BlocCRUDProcessState.fetching));
    DateTime today = DateTime.now();
    String tDay = DateTimeUtils.yMmDd.format(today);
    // SELECT * from promotion Where (start_date >= "2025-02-02" OR start_date IS NULL)
    // AND (end_date <= "2025-02-29" OR end_date IS NULL);
    List<Map<String, dynamic>> jList = await _helper.rawQueryC(
        '''SELECT * from ${DBConstant.promotionTable} WHERE (start_date <= "$tDay" OR start_date IS NULL) AND (end_date >= "$tDay" OR end_date IS NULL)''');
    List<Promotions> promotions = [];
    List<Promotions> tmp = [];
    jList.forEach((element) {
      promotions.add(Promotions.fromJson(element));
    });

    List<Map<String, dynamic>> rList = await _helper.readRowsWhereIn(
        tableName: DBConstant.rewardLineTable,
        where: DBConstant.buyXGetYId,
        queryValues: promotions.map((e) => e.id).toList());

    List<RewardLine> rewards = [];
    rList.forEach((element) {
      rewards.add(RewardLine.fromJsonDB(element));
    });

    promotions.forEach((element) {
      final rLine =
          rewards.where((line) => element.id == line.buyXGetYId).toList();
      List<RewardLine> lines = [];
      rLine.forEach((xx) {
        xx.buyXGetYName = element.name;
        xx.description = element.description;
        lines.add(xx);
      });
      element.rewardLine = lines;
      tmp.add(element);
    });

    MMTApplication.currentPromotions = tmp;
    emit(state.copyWith(
        promotions: tmp, state: BlocCRUDProcessState.fetchSuccess));
  }
}
