// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'report.dart';
import 'user.dart';

class FoodDelivery {
  FoodDelivery({
    required this.user,
    required this.reports,
    this.monthFine = 0,
  });

  final User user;
  final List<Report> reports;
  int monthFine = 0;

  factory FoodDelivery.fromMap(Map<String, dynamic> map) {
    FoodDelivery foodDelivery = FoodDelivery(
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      reports: List<Report>.from(
        (map['reports'] as List).map<Report>(
          (x) => Report.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );

    int fine = 0;
    for (final element in foodDelivery.reports) {
      fine += element.fine;
    }

    return foodDelivery.copyWith(fine: fine);
  }

  factory FoodDelivery.fromJson(String source) =>
      FoodDelivery.fromMap(json.decode(source) as Map<String, dynamic>);

  FoodDelivery copyWith({User? user, List<Report>? reports, int? fine}) {
    return FoodDelivery(
      user: user ?? this.user,
      reports: reports ?? this.reports,
      monthFine: fine ?? monthFine,
    );
  }

  @override
  String toString() => 'FoodDelivery(user: $user, reports: $reports)';

  @override
  bool operator ==(covariant FoodDelivery other) {
    if (identical(this, other)) return true;

    return other.user == user && listEquals(other.reports, reports);
  }

  @override
  int get hashCode {
    return Object.hashAll([
      user,
      reports,
    ]);
  }
}
