import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mylis/domain/entities/member.dart';
import 'package:mylis/domain/repository/member.dart';
import 'package:mylis/infrastructure/member.dart';
import 'package:mylis/presentation/page/customize/controller/customize_state.dart';
import 'package:mylis/theme/color.dart';

class CustomizeController extends StateNotifier<CustomizeState> {
  CustomizeController({
    required this.memberRepository,
  }) : super(
          const CustomizeState(
            textColor: ThemeColor.orange,
            buttonColor: ThemeColor.orange,
            iconColor: ThemeColor.orange,
          ),
        );

  MemberRepository memberRepository;

  Future<void> initialized(Member member) async {
    state = state.copyWith(
      textColor: Color(member.textColor),
      buttonColor: Color(member.buttonColor),
      iconColor: Color(member.iconColor),
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

  Future<void> update(Member member) async {
    final postData = Member(
      uuid: member.uuid,
      email: member.email,
      password: member.password,
      textColor: state.textColor.value,
      buttonColor: state.buttonColor.value,
      iconColor: state.iconColor.value,
      isRemovedAds: member.isRemovedAds,
      isHiddenSaveMemoNoticeDialog: member.isHiddenSaveMemoNoticeDialog,
      registeredArticleCount: member.registeredArticleCount,
      createdAt: member.createdAt,
      updatedAt: member.updatedAt,
      deletedAt: member.deletedAt,
    );
    await memberRepository.update(postData).then(
          (value) => {
            state = state.copyWith(
              textColor: Color(value.textColor),
              buttonColor: Color(value.buttonColor),
              iconColor: Color(value.iconColor),
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
