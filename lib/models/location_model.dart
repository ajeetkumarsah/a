import 'package:meta/meta.dart';

class LocationModel {
  LocationModel({
    required this.ip,
    required this.version,
    required this.city,
    required this.region,
    required this.regionCode,
    required this.country,
    required this.countryName,
    required this.countryCode,
    required this.countryCodeIso3,
    required this.countryCapital,
    required this.countryTld,
    required this.continentCode,
    required this.inEu,
    required this.postal,
    required this.timezone,
    required this.utcOffset,
    required this.countryCallingCode,
    required this.currency,
    required this.currencyName,
    required this.languages,
    required this.asn,
    required this.org,
  });

  String ip;
  String version;
  String city;
  String region;
  String regionCode;
  String country;
  String countryName;
  String countryCode;
  String countryCodeIso3;
  String countryCapital;
  String countryTld;
  String continentCode;
  bool inEu;
  String postal;

  String timezone;
  String utcOffset;
  String countryCallingCode;
  String currency;
  String currencyName;
  String languages;

  String asn;
  String org;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        ip: json["ip"],
        version: json["version"],
        city: json["city"],
        region: json["region"],
        regionCode: json["region_code"],
        country: json["country"],
        countryName: json["country_name"],
        countryCode: json["country_code"],
        countryCodeIso3: json["country_code_iso3"],
        countryCapital: json["country_capital"],
        countryTld: json["country_tld"],
        continentCode: json["continent_code"],
        inEu: json["in_eu"],
        postal: json["postal"],
        timezone: json["timezone"],
        utcOffset: json["utc_offset"],
        countryCallingCode: json["country_calling_code"],
        currency: json["currency"],
        currencyName: json["currency_name"],
        languages: json["languages"],
        asn: json["asn"],
        org: json["org"],
      );
}
