import 'package:flutter/material.dart';

class TemperatureCalculatorPage extends StatefulWidget {
  const TemperatureCalculatorPage({super.key});

  @override
  _TemperatureCalculatorPageState createState() => _TemperatureCalculatorPageState();
}

class _TemperatureCalculatorPageState extends State<TemperatureCalculatorPage> {
  final TextEditingController _temperatureController = TextEditingController();
  double? result;
  String fromScale = 'Celsius'; // Default skala asal
  String toScale = 'Fahrenheit'; // Default skala tujuan

  // Fungsi untuk menghitung konversi suhu
  void calculateConversion() {
    if (_temperatureController.text.isEmpty) {
      showErrorDialog('Silakan masukkan suhu yang ingin dikonversi.');
      return;
    }

    double inputTemperature = double.tryParse(_temperatureController.text) ?? -1;
    if (inputTemperature == -1) {
      showErrorDialog('Masukkan suhu yang valid.');
      return;
    }

    setState(() {
      // Konversi suhu berdasarkan skala
      if (fromScale == 'Celsius') {
        if (toScale == 'Fahrenheit') {
          result = (inputTemperature * 9 / 5) + 32;
        } else if (toScale == 'Kelvin') {
          result = inputTemperature + 273.15;
        } else if (toScale == 'Reamur') {
          result = inputTemperature * 4 / 5;
        }
      } else if (fromScale == 'Fahrenheit') {
        if (toScale == 'Celsius') {
          result = (inputTemperature - 32) * 5 / 9;
        } else if (toScale == 'Kelvin') {
          result = (inputTemperature - 32) * 5 / 9 + 273.15;
        } else if (toScale == 'Reamur') {
          result = (inputTemperature - 32) * 4 / 9;
        }
      } else if (fromScale == 'Kelvin') {
        if (toScale == 'Celsius') {
          result = inputTemperature - 273.15;
        } else if (toScale == 'Fahrenheit') {
          result = (inputTemperature - 273.15) * 9 / 5 + 32;
        } else if (toScale == 'Reamur') {
          result = (inputTemperature - 273.15) * 4 / 5;
        }
      } else if (fromScale == 'Reamur') {
        if (toScale == 'Celsius') {
          result = inputTemperature * 5 / 4;
        } else if (toScale == 'Fahrenheit') {
          result = (inputTemperature * 9 / 4) + 32;
        } else if (toScale == 'Kelvin') {
          result = (inputTemperature * 5 / 4) + 273.15;
        }
      }
    });
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
        title: const Text('Temperature Calculator'),
        backgroundColor: const Color(0xFF8D6E63),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Input suhu
            TextField(
              controller: _temperatureController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Masukkan suhu ($fromScale)',
                labelStyle: const TextStyle(fontSize: 18),
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih skala suhu asal dan tujuan
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
                      // Tukar skala suhu asal dan tujuan
                      String temp = fromScale;
                      fromScale = toScale;
                      toScale = temp;
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
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Menambah ukuran tombol
                backgroundColor: const Color(0xFF8D6E63), // Warna latar belakang tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Membuat sudut tombol melengkung
                ),
              ),
              child: const Text(
                'Konversi',
                style: TextStyle(
                  fontSize: 18, // Ukuran teks tombol
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Warna teks tombol
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
                    'Hasil: ${result!.toStringAsFixed(2)} $toScale',
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
  Widget _buildDropdownButton(String scaleType, {required Color backgroundColor}) {
    String selectedScale = scaleType == 'from' ? fromScale : toScale; // Tentukan skala yang digunakan
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor, // Warna latar belakang berdasarkan input HEX
        border: Border.all(color: Colors.grey.shade400), // Border dropdown
        borderRadius: BorderRadius.circular(8), // Sudut melengkung container
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedScale,
        isExpanded: true,
        dropdownColor: backgroundColor, // Warna dropdown saat dibuka
        underline: Container(), // Menghapus garis bawah dropdown bawaan
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black, // Warna teks dropdown
        ),
        items: ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur'].map((scale) {
          return DropdownMenuItem<String>(
            value: scale,
            child: Text(scale),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (scaleType == 'from') {
              fromScale = value!;
            } else {
              toScale = value!;
            }
          });
        },
      ),
    );
  }
}

