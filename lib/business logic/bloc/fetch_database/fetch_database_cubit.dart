import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api_error_handler.dart';
import '../../../api/api_repo/login_api_repo.dart';
import '../../../model/readable_api_error.dart';
import '../../../src/mmt_application.dart';

part 'fetch_database_state.dart';

class FetchDatabaseCubit extends Cubit<FetchDatabaseState> {
  final LoginApiRepo _loginApiRepo;

  FetchDatabaseCubit()
      : _loginApiRepo = LoginApiRepo(),
        super(FetchDatabaseInitial());

  fetchDatabase() async {
    emit(FetchDatabaseFetching());
    try {
      List<String> databaseList = await _loginApiRepo.fetchDatabases();
      MMTApplication.databaseList = databaseList;
      emit(FetchDatabaseSuccess(databaseList));
    } on DioException catch (e) {
      emit(FetchDatabaseFail(
          ReadableApiError(message: e.type.name, errorCode: 0)));
    } on Exception catch (e) {
      emit(FetchDatabaseFail(const ReadableApiError(
          message: ApiErrorHandler.internetError, errorCode: 0)));
    }
  }
}
