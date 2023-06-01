// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HistoryModel {
  final int id;
  final int score;
  final DateTime date;
  HistoryModel({
    required this.id,
    required this.score,
    required this.date,
  });


  HistoryModel copyWith({
    int? id,
    int? score,
    DateTime? date,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      score: score ?? this.score,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'score': score,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] as int,
      score: map['score'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) => HistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistoryModel(id: $id, score: $score, date: $date)';

  @override
  bool operator ==(covariant HistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.score == score &&
      other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ score.hashCode ^ date.hashCode;
}
