import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExchangeRateScreen extends StatefulWidget {
  @override
  _ExchangeRateScreenState createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateScreen> {
  Map<String, dynamic> exchangeRates = {};

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final apiKey =
        'https://v6.exchangeratesapi.io/latest?base=USD&access_key=db380e64b6237e0ae7169b7eeca10cae'; // แทน YOUR_API_KEY ด้วย API Key ที่คุณได้รับ
    final url =
        'https://v6.exchangeratesapi.io/latest?base=USD&access_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        exchangeRates = data['rates'];
      });
    } else {
      throw Exception('Failed to fetch exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange Rates'),
      ),
      body: exchangeRates.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final currency = exchangeRates.keys.toList()[index];
                final rate = exchangeRates[currency];
                return ListTile(
                  title: Text(currency),
                  subtitle: Text('Rate: $rate'),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Exchange Rate App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ExchangeRateScreen(),
  ));
}
