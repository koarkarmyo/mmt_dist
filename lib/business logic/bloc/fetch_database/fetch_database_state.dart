part of 'fetch_database_cubit.dart';

@immutable
abstract class FetchDatabaseState {}

class FetchDatabaseInitial extends FetchDatabaseState {}

class FetchDatabaseFetching extends FetchDatabaseState {}

class FetchDatabaseSuccess extends FetchDatabaseState {
  final List<String> databaseList;

  FetchDatabaseSuccess(this.databaseList);
}

class FetchDatabaseFail extends FetchDatabaseState {
  final ReadableApiError apiError;

  FetchDatabaseFail(this.apiError);
}
