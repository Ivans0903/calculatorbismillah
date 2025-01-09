import 'package:flutter/material.dart';

class CurrencyCalculatorPage extends StatefulWidget {
  const CurrencyCalculatorPage({super.key});

  @override
  _CurrencyCalculatorPageState createState() => _CurrencyCalculatorPageState();
}

class _CurrencyCalculatorPageState extends State<CurrencyCalculatorPage> {
  final TextEditingController _amountController = TextEditingController();
  double? result;
  String fromCurrency = 'IDR'; // Default source currency
  String toCurrency = 'USD'; // Default target currency

  final Map<String, double> baseExchangeRates = {
    'IDR': 14920.0,
    'USD': 1.0,
    'EUR': 0.85,
    'JPY': 110.0,
    'SAR': 3.75,
    'GBP': 0.74,
    'AUD': 1.34,
    'CAD': 1.25,
    'INR': 73.5,
    'CNY': 6.45,
  };

  void calculateConversion() {
    if (_amountController.text.isEmpty) {
      showErrorDialog('Please enter an amount to convert.');
      return;
    }

    double inputAmount = double.tryParse(_amountController.text) ?? -1;
    if (inputAmount <= 0) {
      showErrorDialog('Enter a valid amount greater than 0.');
      return;
    }

    setState(() {
      double fromRate = baseExchangeRates[fromCurrency] ?? 1.0;
      double toRate = baseExchangeRates[toCurrency] ?? 1.0;
      result = (inputAmount / fromRate) * toRate;
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Currency Calculator \$'),
        backgroundColor: const Color(0xFF8D6E63),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input amount
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Enter amount ($fromCurrency)',
                  labelStyle: const TextStyle(color: Color(0xFF5D4037)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown for selecting currencies
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCurrencyDropdown(fromCurrency, (value) {
                  setState(() {
                    fromCurrency = value!;
                  });
                }),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 32, color: Color(0xFF8D6E63)),
                  onPressed: () {
                    setState(() {
                      String temp = fromCurrency;
                      fromCurrency = toCurrency;
                      toCurrency = temp;
                    });
                  },
                ),
                _buildCurrencyDropdown(toCurrency, (value) {
                  setState(() {
                    toCurrency = value!;
                  });
                }),
              ],
            ),
            const SizedBox(height: 20),

            // Convert button
            ElevatedButton(
              onPressed: calculateConversion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF8D6E63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Convert', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),

            // Conversion result
            if (result != null)
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD7CCC8), Color(0xFFFBE9E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Result: ${result!.toStringAsFixed(2)} $toCurrency',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String selectedCurrency, ValueChanged<String?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        value: selectedCurrency,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(12),
        items: baseExchangeRates.keys.map((currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(
              currency,
              style: const TextStyle(color: Color(0xFF5D4037), fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
