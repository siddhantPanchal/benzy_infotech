import 'dart:convert';

import 'breakfast_enum.dart';

class Report {
  Report(
    this.date,
    this.optIns,
    {totalFine = 0}
  ){
    this._totalFine = totalFine;
  }

  final String date;
  final OptInsClass? optIns;
  int _totalFine = 0;

  int get fine => _totalFine;

  factory Report.fromMap(Map<String, dynamic> map) {
    // print(map);
    Report result = Report(
      (map['date'] ?? '') as String,
      (map['opt_ins'] is List)
          ? null
          : OptInsClass.fromMap(map['opt_ins'] as Map<String, dynamic>),
    );
    int count = 0;
    if (result.optIns?.breakfast == Breakfast.pending) {
      count += 1;
    }
    if (result.optIns?.lunch == Breakfast.pending) {
      count += 1;
    }
    if (result.optIns?.dinner == Breakfast.pending) {
      count += 1;
    }
    result = result.copyWith(fine:  count * 100);

    return result;
  }

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  Report copyWith({
    String? date,
    OptInsClass? optIns,
    int? fine,
  }) {
    return Report(
      date ?? this.date,
      optIns ?? this.optIns,
      totalFine : fine ?? this.fine,
    );
  }

  @override
  bool operator ==(covariant Report other) {
    if (identical(this, other)) return true;

    return other.date == date && other.optIns == optIns;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      date,
      optIns,
    ]);
  }

  @override
  String toString() => 'Report(date: $date, optIns: $optIns)';
}
