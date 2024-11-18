part of 'lot_cubit.dart';

class LotState {
  List<Lot> lotList;
  BlocCRUDProcessState state;

  LotState({required this.lotList,required this.state});

  LotState copyWith({List<Lot>? lotList, BlocCRUDProcessState? state}){
    return LotState(lotList: lotList ?? this.lotList, state: state ?? this.state);
  }

}

