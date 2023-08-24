import 'dart:convert';

ExchangRate exchangRateFromJson(String str) => ExchangRate.fromJson(json.decode(str));

String exchangRateToJson(ExchangRate data) => json.encode(data.toJson());

class ExchangRate {
    bool success;
    int timestamp;
    String base;
    DateTime date;
    Map<String, double> rates;

    ExchangRate({
        required this.success,
        required this.timestamp,
        required this.base,
        required this.date,
        required this.rates,
    });

    factory ExchangRate.fromJson(Map<String, dynamic> json) => ExchangRate(
        success: json["success"],
        timestamp: json["timestamp"],
        base: json["base"],
        date: DateTime.parse(json["date"]),
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "timestamp": timestamp,
        "base": base,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
