import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/member.dart';
import 'package:mylis/presentation/page/customize/controller/customize_state.dart';

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
      textColor: Color(int.parse(member.textColor)),
      buttonColor: Color(int.parse(member.buttonColor)),
      iconColor: Color(int.parse(member.iconColor)),
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
          textColor: state.textColor.value.toString(),
          buttonColor: state.buttonColor.value.toString(),
          iconColor: state.iconColor.value.toString(),
        )
        .then(
          (value) => {
            state = state.copyWith(
              textColor: Color(int.parse(value.textColor)),
              buttonColor: Color(int.parse(value.buttonColor)),
              iconColor: Color(int.parse(value.iconColor)),
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
