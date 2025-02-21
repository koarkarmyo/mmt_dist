part of 'promotion_cubit.dart';

@immutable
class PromotionState {
  final List<Promotions> promotions;
  final BlocCRUDProcessState state;
  final String? error;

  PromotionState({
    required this.promotions,
    required this.state,
    this.error,
  });

  PromotionState copyWith({
    List<Promotions>? promotions,
    BlocCRUDProcessState? state,
    String? error,
  }) {
    return PromotionState(
      promotions: promotions ?? this.promotions,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'PromotionState{promotions: $promotions, state: ${state.name}, error: $error}';
  }
}
