import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';

import 'bloc/promotion_bloc.dart';
import 'bloc/promotion_event.dart';
import 'bloc/promotion_state.dart';

/// Promotion stateful widget.
@immutable
class Promotion extends StatefulWidget {
  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends BaseState<Promotion> {
  final TextEditingController _promotionCodeController = TextEditingController();
  final PromotionBloc _promotionBloc = PromotionBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PromotionBloc>(
      builder: (BuildContext context) => _promotionBloc,
      child: BlocListener<PromotionBloc, PromotionState>(
        listener: (BuildContext context, PromotionState state) {
        },
        child: BlocBuilder<PromotionBloc, PromotionState>(
          bloc: _promotionBloc,
          builder: (BuildContext context, PromotionState state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Mã khuyến mãi', style: TextStyles.textStyle14PrimaryGrey),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: EditTextField(
                          title: 'Mã khuyến mãi',
                          hint: 'Mã khuyến mãi',
                          hasLabel: false,
                          error: state is PromotionFailure ? state.error : '',
                          controller: _promotionCodeController,
                        )
                      ),
                      const SizedBox(width: 10.0),
                      PrimaryButton(
                        backgroundColor: AppColors.lightPrimaryColor,
                        text: 'Áp Dụng',
                        height: 40.0,
                        hasShadow: false,
                        onPressed: _handleApplyPromotionCode,
                      )
                    ],
                  )
                ],
              )
            );
          }
        )
      )
    );
  }

  @override
  void dispose() {
    _promotionBloc.dispose();
    super.dispose();
  }

  void _handleApplyPromotionCode() {
    _promotionBloc.dispatch(PromotionValidationEvent(promotionCode: _promotionCodeController.text));
  }
}
