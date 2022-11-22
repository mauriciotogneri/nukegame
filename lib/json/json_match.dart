import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  final String id;
  final List<String> players;

  const JsonMatch({
    this.id = '',
    this.players = const [],
  });

  factory JsonMatch.fromString(String json) => JsonMatch.fromJson(jsonDecode(json));

  factory JsonMatch.fromJson(Map<String, dynamic> json) => _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
