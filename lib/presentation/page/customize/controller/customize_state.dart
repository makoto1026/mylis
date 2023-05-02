// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'customize_state.freezed.dart';

@freezed
class CustomizeState with _$CustomizeState {
  const factory CustomizeState({
    required Color textColor,
    required Color buttonColor,
    required Color iconColor,
  }) = _CustomizeState;
  const CustomizeState._();
}
