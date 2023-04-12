import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/member.dart';
import 'package:mylis/presentation/page/customize/controller/customize_state.dart';
import 'package:mylis/snippets/color.dart';

class CustomizeController extends StateNotifier<CustomizeState> {
  CustomizeController({
    required this.memberRepository,
  }) : super(
          const CustomizeState(
            textColor: Colors.white,
            buttonColor: Colors.white,
            iconColor: Colors.white,
          ),
        );

  MemberRepository memberRepository;

  Future<void> initialized(Member member) async {
    state = state.copyWith(
      textColor: changeStringToColor(member.textColor),
      buttonColor: changeStringToColor(member.buttonColor),
      iconColor: changeStringToColor(member.iconColor),
    );
  }

  Future<void> setTextColor(Color color) async {
    state = state.copyWith(textColor: color);
  }

  Future<void> setButtonColor(Color color) async {
    state = state.copyWith(buttonColor: color);
  }

  Future<void> setIconColor(Color color) async {
    state = state.copyWith(iconColor: color);
  }

  Future<void> update(String currentMemberId) async {
    await memberRepository
        .update(
          currentMemberId: currentMemberId,
          textColor: changeColorToString(state.textColor),
          buttonColor: changeColorToString(state.buttonColor),
          iconColor: changeColorToString(state.iconColor),
        )
        .then(
          (value) => {
            state = state.copyWith(
              textColor: changeStringToColor(value.textColor),
              buttonColor: changeStringToColor(value.buttonColor),
              iconColor: changeStringToColor(value.iconColor),
            ),
          },
        );
  }
}

final customizeController =
    StateNotifierProvider<CustomizeController, CustomizeState>(
  (ref) => CustomizeController(
    memberRepository: ref.watch(memberRepositoryProvider),
  ),
);
