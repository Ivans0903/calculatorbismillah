import 'package:flutter/material.dart';

class WeightConverterPage extends StatefulWidget {
  const WeightConverterPage({super.key});

  @override
  _WeightConverterPageState createState() => _WeightConverterPageState();
}

class _WeightConverterPageState extends State<WeightConverterPage> {
  final TextEditingController _weightController = TextEditingController();
  double? result;
  String fromUnit = 'Kilogram'; // Default satuan asal
  String toUnit = 'Pound'; // Default satuan tujuan

  // Semua satuan berat internasional dan Amerika
  final List<String> weightUnits = [
    // Satuan Internasional
    'Kilogram',
    'Hektogram',
    'Dekagram',
    'Gram',
    'Desigram',
    'Centigram',
    'Milligram',
    // Satuan Amerika
    'Ounce',
    'Pound',
    'Stone',
    'Short Ton',
    'Long Ton',
  ];

  // Fungsi untuk menghitung konversi berat
  void calculateConversion() {
    if (_weightController.text.isEmpty) {
      showErrorDialog('Silakan masukkan berat yang ingin dikonversi.');
      return;
    }

    double inputWeight = double.tryParse(_weightController.text) ?? -1;
    if (inputWeight == -1) {
      showErrorDialog('Masukkan berat yang valid.');
      return;
    }

    setState(() {
      // Konversi berat berdasarkan satuan
      result = convertWeight(inputWeight, fromUnit, toUnit);
    });
  }

  // Fungsi utama untuk melakukan konversi
  double convertWeight(double value, String from, String to) {
    // Konversi nilai dari satuan asal ke Kilogram (sebagai basis)
    double valueInKilogram = value * _getConversionFactor(from);

    // Konversi nilai dari Kilogram ke satuan tujuan
    return valueInKilogram / _getConversionFactor(to);
  }

  // Faktor konversi ke dan dari Kilogram
  double _getConversionFactor(String unit) {
    switch (unit) {
    // Satuan Internasional
      case 'Kilogram':
        return 1; // 1 kg = 1 kg
      case 'Hektogram':
        return 0.1; // 1 hg = 0.1 kg
      case 'Dekagram':
        return 0.01; // 1 dag = 0.01 kg
      case 'Gram':
        return 0.001; // 1 g = 0.001 kg
      case 'Desigram':
        return 0.0001; // 1 dg = 0.0001 kg
      case 'Centigram':
        return 0.00001; // 1 cg = 0.00001 kg
      case 'Milligram':
        return 0.000001; // 1 mg = 0.000001 kg

    // Satuan Amerika
      case 'Ounce':
        return 0.0283495; // 1 oz = 0.0283495 kg
      case 'Pound':
        return 0.453592; // 1 lb = 0.453592 kg
      case 'Stone':
        return 6.35029; // 1 stone = 6.35029 kg
      case 'Short Ton':
        return 907.1847; // 1 short ton = 907.1847 kg
      case 'Long Ton':
        return 1016.0469; // 1 long ton = 1016.0469 kg

      default:
        return 1; // Default ke Kilogram
    }
  }

  // Menampilkan dialog error jika input tidak valid
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
        title: const Text('Weight Converter'),
        backgroundColor: const Color(0xFF8D6E63),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Input berat
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Masukkan berat ($fromUnit)',
                labelStyle: const TextStyle(fontSize: 18),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih satuan berat asal dan tujuan
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDropdownButton(
                  'from',
                  backgroundColor: const Color(0xFF8D6E63), // Warna latar belakang HEX untuk dropdown 'from'
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, size: 32, color: Color(0xFF8D6E63)),
                  onPressed: () {
                    setState(() {
                      // Tukar satuan berat asal dan tujuan
                      String temp = fromUnit;
                      fromUnit = toUnit;
                      toUnit = temp;
                    });
                  },
                ),
                _buildDropdownButton(
                  'to',
                  backgroundColor: const Color(0xFF8D6E63), // Warna latar belakang HEX untuk dropdown 'to'
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tombol untuk melakukan konversi
            ElevatedButton(
              onPressed: calculateConversion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                backgroundColor: const Color(0xFF8D6E63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Konversi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Hasil konversi
            if (result != null)
              Card(
                elevation: 5,
                margin: const EdgeInsets.only(top: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Hasil: ${result!.toStringAsFixed(5)} $toUnit',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String unitType, {required Color backgroundColor}) {
    String selectedUnit = unitType == 'from' ? fromUnit : toUnit; // Tentukan satuan yang digunakan
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedUnit,
        isExpanded: true,
        dropdownColor: backgroundColor,
        underline: Container(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        items: weightUnits.map((unit) {
          return DropdownMenuItem<String>(
            value: unit,
            child: Text(unit, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (unitType == 'from') {
              fromUnit = value!;
            } else {
              toUnit = value!;
            }
          });
        },
      ),
    );
  }
}
