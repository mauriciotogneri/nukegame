import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:nukegame/models/document.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  final String id;
  final List<String> players;

  const JsonMatch({
    this.id = '',
    this.players = const [],
  });

  factory JsonMatch.fromDocument(Document document) => JsonMatch(
        id: document.getString('id')!,
        players: document.getList('players')!.map((e) => e.toString()).toList(),
      );

  factory JsonMatch.fromString(String json) => JsonMatch.fromJson(jsonDecode(json));

  factory JsonMatch.fromJson(Map<String, dynamic> json) => _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
