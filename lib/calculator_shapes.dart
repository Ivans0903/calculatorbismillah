import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalculatorShapesPage extends StatefulWidget {
  const CalculatorShapesPage({super.key});

  @override
  _CalculatorShapesPageState createState() => _CalculatorShapesPageState();
}

class _CalculatorShapesPageState extends State<CalculatorShapesPage> {
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  final TextEditingController _input3Controller = TextEditingController();
  double? result;
  String selectedShape = 'AreaPersegi'; // Default value for area calculation
  String calculationType = 'Luas'; // Default calculation type

  final List<Map<String, dynamic>> areaShapes = [
    {'name': 'Persegi', 'icon': Icons.crop_square, 'value': 'AreaPersegi'},
    {
      'name': 'Persegi Panjang',
      'icon': Icons.view_array,
      'value': 'AreaPersegiPanjang'
    },
    {'name': 'Lingkaran', 'icon': Icons.circle, 'value': 'AreaLingkaran'},
    {
      'name': 'Layang-Layang',
      'icon': Icons.diamond,
      'value': 'AreaLayangLayang'
    },
    {'name': 'Trapesium', 'icon': Icons.architecture, 'value': 'AreaTrapesium'},
    {
      'name': 'Jajargenjang',
      'icon': Icons.category,
      'value': 'AreaJajargenjang'
    },
    {'name': 'Segitiga', 'icon': Icons.terrain, 'value': 'AreaSegitiga'},
  ];

  final List<Map<String, dynamic>> volumeShapes = [
    {'name': 'Kubus', 'icon': FontAwesomeIcons.cube, 'value': 'VolumeKubus'},
    {'name': 'Balok', 'icon': Icons.view_module, 'value': 'VolumeBalok'},
    {'name': 'Bola', 'icon': Icons.sports_baseball, 'value': 'VolumeBola'},
    {
      'name': 'Tabung',
      'icon': Icons.filter_tilt_shift,
      'value': 'VolumeTabung'
    },
    {
      'name': 'Limas Persegi',
      'icon': Icons.architecture,
      'value': 'VolumeLimasPersegi'
    },
    {
      'name': 'Kerucut',
      'icon': FontAwesomeIcons.campground,
      'value': 'VolumeKerucut'
    },
    {
      'name': 'Prisma Segitiga',
      'icon': Icons.change_circle,
      'value': 'VolumePrismaSegitiga'
    },
    {
      'name': 'Limas Segitiga',
      'icon': Icons.terrain,
      'value': 'VolumeLimasSegitiga'
    },
  ];

  void calculateArea() {
    double? input1 = double.tryParse(_input1Controller.text);
    double? input2 = double.tryParse(_input2Controller.text);

    if (input1 == null || input1 <= 0 ||
        (selectedShape != 'AreaLingkaran' && (input2 == null || input2 <= 0))) {
      showErrorDialog('Masukkan nilai yang valid (lebih dari 0).');
      return;
    }

    setState(() {
      switch (selectedShape) {
        case 'AreaPersegi':
          result = input1 * input1;
          break;
        case 'AreaPersegiPanjang':
          result = input1 * input2!;
          break;
        case 'AreaLingkaran':
          result = 3.14 * input1 * input1;
          break;
        case 'AreaLayangLayang':
          result = 0.5 * input1 * input2!;
          break;
        case 'AreaTrapesium':
          result = 0.5 * (input1 + input2!) * input2;
          break;
        case 'AreaJajargenjang':
          result = input1 * input2!;
          break;
        case 'AreaSegitiga':
          result = 0.5 * input1 * input2!;
          break;
        default:
          result = 0;
      }
    });
  }

  void calculateVolume() {
    double? input1 = double.tryParse(_input1Controller.text);
    double? input2 = double.tryParse(_input2Controller.text);
    double? input3 = double.tryParse(_input3Controller.text);

    if (input1 == null || input1 <= 0 ||
        (selectedShape != 'VolumeKubus' && selectedShape != 'VolumeBola' &&
            (input2 == null || input2 <= 0)) ||
        (['VolumeBalok', 'VolumeTabung', 'VolumePrismaSegitiga'].contains(
            selectedShape) && (input3 == null || input3 <= 0))) {
      showErrorDialog('Masukkan nilai yang valid (lebih dari 0).');
      return;
    }

    setState(() {
      switch (selectedShape) {
        case 'VolumeKubus':
          result = input1 * input1 * input1;
          break;
        case 'VolumeBalok':
          result = input1 * input2! * input3!;
          break;
        case 'VolumeBola':
          result = (4 / 3) * 3.14 * (input1 * input1 * input1);
          break;
        case 'VolumeTabung':
          result = 3.14 * (input1 * input1) * input2!;
          break;
        case 'VolumeLimasPersegi':
          result = (1 / 3) * (input1 * input1) * input2!;
          break;
        case 'VolumeKerucut':
          result = (1 / 3) * 3.14 * (input1 * input1) * input2!;
          break;
        case 'VolumePrismaSegitiga':
          result = (0.5 * input1 * input2!) * input3!;
          break;
        case 'VolumeLimasSegitiga':
          result = (1 / 3) * (0.5 * input1 * input2!) * input3!;
          break;
        default:
          result = 0;
      }
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
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
        backgroundColor: const Color(0xFF8D6E63),
        centerTitle: true, // Center the title
        elevation: 0, // Remove shadow
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Kalkulator Luas dan Volume',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8), // Add spacing between text and icon
                Icon(
                  FontAwesomeIcons.cube, // Use the appropriate icon
                  color: Colors.white, // Match the AppBar text color
                  size: 20, // Adjust the size
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Calculation Type Selection
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFBE9E7),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRadioButton('Luas'),
                    const SizedBox(width: 16), // Add spacing between buttons
                    _buildRadioButton('Volume'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Shape Selection Dropdown
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedShape,
                  underline: const SizedBox(),
                  items: (calculationType == 'Luas' ? areaShapes : volumeShapes)
                      .map((shape) {
                    return DropdownMenuItem<String>(
                      value: shape['value'],
                      child: Row(
                        children: [
                          Icon(shape['icon'], color: const Color(0xFF8D6E63)),
                          const SizedBox(width: 10),
                          Text(
                            shape['name'],
                            style: const TextStyle(
                              color: Color(0xFF5D4037),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedShape = value!;
                      _input1Controller.clear();
                      _input2Controller.clear();
                      _input3Controller.clear();
                      result = null;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Input Fields
              _buildTextField(
                label: calculationType == 'Luas'
                    ? 'Panjang/Jari-jari'
                    : 'Nilai 1',
                controller: _input1Controller,
              ),
              if (selectedShape != 'AreaLingkaran' &&
                  selectedShape != 'VolumeKubus' &&
                  selectedShape != 'VolumeBola')
                const SizedBox(height: 16),
              if (selectedShape != 'AreaLingkaran' &&
                  selectedShape != 'VolumeKubus' &&
                  selectedShape != 'VolumeBola')
                _buildTextField(
                    label: 'Nilai 2', controller: _input2Controller),
              if (['VolumeBalok', 'VolumeTabung', 'VolumePrismaSegitiga']
                  .contains(selectedShape))
                const SizedBox(height: 16),
              if (['VolumeBalok', 'VolumeTabung', 'VolumePrismaSegitiga']
                  .contains(selectedShape))
                _buildTextField(
                    label: 'Nilai 3', controller: _input3Controller),

              const SizedBox(height: 20),

              // Calculate Button
              ElevatedButton(
                onPressed: calculationType == 'Luas'
                    ? calculateArea
                    : calculateVolume,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF8D6E63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  calculationType == 'Luas' ? 'Hitung Luas' : 'Hitung Volume',
                ),
              ),

              // Result Card
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
                      'Hasil: ${result!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D6E63),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

// Helper: Build Radio Buttons
  Widget _buildRadioButton(String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: calculationType,
            onChanged: (newValue) {
              setState(() {
                calculationType = newValue!;
                selectedShape = calculationType == 'Luas'
                    ? areaShapes.first['value']
                    : volumeShapes.first['value'];
                result = null;
                _input1Controller.clear();
                _input2Controller.clear();
                _input3Controller.clear();
              });
            },
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Color(0xFF5D4037)),
          ),
        ],
      ),
    );
  }

// Helper: Build Text Fields
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF8D6E63)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF8D6E63), // Stroke color
            width: 1.5, // Stroke width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF8D6E63), // Stroke color when focused
            width: 2, // Stroke width when focused
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF8D6E63), // Default stroke color
          ),
        ),
      ),
    );
  }
}
