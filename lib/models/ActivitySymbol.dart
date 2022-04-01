import 'package:flutter/material.dart';

class ActivitySymbol {
  String? id, name, symbName, v, url;
  final bool? isDeactivated;
  final String? mobileIcon;

  ActivitySymbol(
      {this.id,
      this.name,
      this.symbName,
      this.v,
      this.isDeactivated,
      this.url,
      this.mobileIcon});

  factory ActivitySymbol.fromJson(Map<String, dynamic> json) {
    return ActivitySymbol(
      id: json["_id"],
      name: json["name"],
      symbName: json["symbName"],
      v: json["_v"],
      isDeactivated: json["isDeactivated"],
      url: json["url"],
      mobileIcon: json["mobileIcon"],
    );
  }

  getId() => id;
}
