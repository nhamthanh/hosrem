import 'dart:async';

import 'package:bloc/bloc.dart';

import 'promotion_event.dart';
import 'promotion_state.dart';

/// Promotion bloc to validate promotion code.
class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  @override
  PromotionState get initialState => PromotionLoading();

  @override
  Stream<PromotionState> mapEventToState(PromotionEvent event) async* {
    if (event is PromotionValidationEvent) {
      yield PromotionFailure(error: event.promotionCode.isEmpty ? '' : 'Mã khuyến mãi không đúng');
    }
  }
}
