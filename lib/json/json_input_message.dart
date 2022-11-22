import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nukegame/types/finish_state.dart';

part 'json_input_message.g.dart';

@JsonSerializable()
class JsonInputMessage {
  final String? playerName;
  final String? matchId;
  final int? laneId;
  final int? amount;
  final int? direction;
  final int? attackLevel;
  final FinishState? finishState;

  const JsonInputMessage({
    this.playerName,
    this.matchId,
    this.laneId,
    this.amount,
    this.direction,
    this.attackLevel,
    this.finishState,
  });

  factory JsonInputMessage.fromString(String json) => JsonInputMessage.fromJson(jsonDecode(json));

  factory JsonInputMessage.fromJson(Map<String, dynamic> json) => _$JsonInputMessageFromJson(json);

  Map<String, dynamic> toJson() => _$JsonInputMessageToJson(this);
}
