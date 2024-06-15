import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = '0432227';

class CurrencyRatesPage extends StatefulWidget {
  @override
  _CurrencyRatesPageState createState() => _CurrencyRatesPageState();
}

class _CurrencyRatesPageState extends State<CurrencyRatesPage> {
  List<Map<String, dynamic>> currencyRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrencyRates();
  }

  Future<void> fetchCurrencyRates() async {
    final url = Uri.parse('https://api.hgbrasil.com/finance?key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('Data received: $data');

      if (data.containsKey('results') && data['results'].containsKey('currencies')) {
        final Map<String, dynamic> currencies = data['results']['currencies'];
        print('Currencies: $currencies');

        List<Map<String, dynamic>> loadedRates = [];

        currencies.forEach((key, value) {
          print('Processing currency: $key, value: $value');
          if (value is Map<String, dynamic>) {
            loadedRates.add({
              'name': value['name'] ?? 'Unknown',
              'code': key,
              'rate': value['buy']?.toDouble() ?? 0.0, // Usando o valor de compra
            });
          } else {
            print('Unexpected value format for key: $key, value: $value');
          }
        });

        setState(() {
          currencyRates = loadedRates;
          isLoading = false;
        });
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load currency rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotações de Moedas'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencyRates.length,
              itemBuilder: (context, index) {
                final currency = currencyRates[index];
                return CurrencyRateListItem(
                  name: currency['name'],
                  code: currency['code'],
                  rate: currency['rate'],
                );
              },
            ),
    );
  }
}

class CurrencyRateListItem extends StatelessWidget {
  final String name;
  final String code;
  final double rate;

  const CurrencyRateListItem({
    required this.name,
    required this.code,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(code),
        ),
        title: Text(name),
        subtitle: Text('R\$ ${rate.toStringAsFixed(2)}'), // Formatação do preço,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CurrencyRatesPage(),
  ));
}
