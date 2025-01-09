import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'calculator_shapes.dart'; // Import kalkulator shapes
import 'weight_conversion.dart'; // Import halaman konversi berat
import 'currency_calculator.dart'; // Import kalkulator currency
import 'calculator_tips.dart'; // Import kalkulator tips
import 'temperature_calculator.dart'; // Import kalkulator temperatur
import 'friends.dart'; // Import buku telepon
import 'login_page.dart'; // Import halaman login untuk chat
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // File ini dihasilkan oleh FlutterFire CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CalculatorApp());
  // runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Firebase App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const CalculatorHome(), // Ubah ini ke halaman utama aplikasi Anda
//     );
//   }
// }

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF8D6E63), // Warm brown tone
        scaffoldBackgroundColor: const Color(0xFFFBE9E7), // Light beige
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF8D6E63),
          secondary: Color(0xFFD7CCC8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8D6E63),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xFFFBE9E7),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle( // Updated from bodyText1
            color: Color(0xFF5D4037),
            fontSize: 16,
          ),
          bodyMedium: TextStyle( // Updated from bodyText2
            color: Color(0xFF5D4037),
            fontSize: 14,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF8D6E63),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8D6E63),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFEDE7F6), // Subtle lavender tone
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          hintStyle: TextStyle(
            color: Color(0xFF5D4037),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFFECEFF1),
          textColor: Color(0xFF5D4037),
          iconColor: Color(0xFF8D6E63),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: const CalculatorHome(),
    );
  }
}


class GlobalDrawer extends StatelessWidget {
  final String currentPage;

  const GlobalDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF8D6E63), // Updated color to match theme
            ),
            child: Text(
              'Menu Kalkulator',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.calculate,
            title: 'Kalkulator Biasa',
            targetPage: 'CalculatorHome',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.architecture,
            title: 'Kalkulator Bangun Ruang',
            targetPage: 'CalculatorShapesPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.currency_exchange,
            title: 'Kalkulator Mata Uang',
            targetPage: 'CurrencyCalculatorPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.lightbulb,
            title: 'Kalkulator Tips',
            targetPage: 'CalculatorTipsPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.thermostat,
            title: 'Kalkulator Temperatur',
            targetPage: 'TemperatureCalculatorPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.line_weight, // Ikon untuk konversi berat
            title: 'Kalkulator Berat',
            targetPage: 'WeightConverterPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.contacts,
            title: 'Buku Telepon',
            targetPage: 'FriendsPage',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.chat,
            title: 'Chat',
            targetPage: 'ChatPage',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String title, required String targetPage}) {
    return InkWell(
      onTap: () {
        if (currentPage != targetPage) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (targetPage) {
                  case 'CalculatorHome':
                    return const CalculatorHome();
                  case 'CalculatorShapesPage':
                    return const CalculatorShapesPageWithDrawer();
                  case 'CurrencyCalculatorPage':
                    return const CurrencyCalculatorPageWithDrawer();
                  case 'CalculatorTipsPage':
                    return const CalculatorTipsPageWithDrawer();
                  case 'TemperatureCalculatorPage':
                    return const TemperatureCalculatorPageWithDrawer();
                  case 'FriendsPage':
                    return const FriendsPageWithDrawer();
                  case 'ChatPage':
                    return const LoginPage();
                  case 'WeightConverterPage': // Tambahkan logika ini
                    return const WeightConverterPageWithDrawer();
                  default:
                    return const CalculatorHome();
                }
              },
            ),
          );
        } else {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        // Jarak antar item
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        // Padding dalam item
        decoration: BoxDecoration(
          color: currentPage == targetPage
              ? const Color(0xFFD7CCC8) // Warna untuk halaman aktif
              : Colors.transparent, // Warna default transparan
          borderRadius: BorderRadius.circular(10), // Membuat sudut melengkung
        ),
        child: Row(
          children: [
            // Ikon dengan latar belakang bulat
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF8D6E63), // Warna ikon latar belakang
                shape: BoxShape.circle, // Membuat ikon bulat
              ),
              child: Icon(
                icon,
                color: Colors.white, // Warna ikon
                size: 20, // Ukuran ikon
              ),
            ),
            const SizedBox(width: 15), // Spasi antara ikon dan teks
            // Teks dengan gaya yang lebih tebal
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16, // Ukuran font lebih besar
                  fontWeight: FontWeight.w600, // Membuat teks tebal
                  color: currentPage == targetPage
                      ? const Color(
                      0xFF5D4037) // Warna teks untuk halaman aktif
                      : const Color(0xFF8D6E63), // Warna teks default
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String input = '';
  String result = '0';
  final int maxResult = 1000000000;

  void appendInput(String value) {
    setState(() {
      const operators = ['+', '-', 'x', '÷'];

      if (input.isEmpty && value == '-') {
        input += value;
      } else if (input.isNotEmpty) {
        String lastChar = input[input.length - 1];

        if (operators.contains(lastChar) && operators.contains(value)) {
          if (!(lastChar == '-' && value == '-')) {
            input = input.substring(0, input.length - 1) + value;
          }
        } else {
          input += value;
        }
      } else {
        input += value;
      }
    });
  }

  void calculateResult() {
    try {
      if (input.isEmpty) return;

      String evalInput = input.replaceAll('x', '*').replaceAll('÷', '/');
      evalInput = evalInput.replaceAllMapped(
          RegExp(r'√(\d+(\.\d+)?)'), (Match m) => 'sqrt(${m.group(1)})');

      evalInput = evalInput.replaceAllMapped(
        RegExp(r'(sin|cos|tan)\(([^)]+)\)'),
            (match) {
          String function = match.group(1)!;
          String angle = match.group(2)!;
          double radians = double.parse(angle) * (3.141592653589793 / 180);
          return '$function($radians)';
        },
      );

      Parser parser = Parser();
      Expression exp = parser.parse(evalInput);
      ContextModel cm = ContextModel();
      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      if (evalResult.abs() > maxResult) {
        result = 'Maksimal: $maxResult';
      } else {
        result = evalResult.toStringAsFixed(2);
        if (result.endsWith('.00')) {
          result = result.substring(0, result.length - 3);
        }
      }
    } catch (e) {
      result = 'Error';
    }
    setState(() {});
  }

  void clearInput() {
    setState(() {
      input = '';
      result = '0';
    });
  }

  void deleteLast() {
    if (input.isNotEmpty) {
      setState(() {
        input = input.substring(0, input.length - 1);
      });
    }
  }

  void addTrigFunction(String func) {
    setState(() {
      input += '$func(';
    });
  }

  void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator Biasa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF8D6E63), // Match theme
        centerTitle: true,
      ),
      drawer: const GlobalDrawer(currentPage: 'CalculatorHome'),
      body: GestureDetector(
        onTap: () => _hideKeyboard(context),
        child: buildCalculatorTab(),
      ),
    );
  }

  Widget buildCalculatorTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Input Display
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFBE9E7), Color(0xFFD7CCC8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8D6E63),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Divider(color: Colors.grey),

        // Buttons
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ...buildButtons([
                  'sin', 'cos', 'tan', '√',
                  '(', ')', 'C', '⌫',
                  '7', '8', '9', '÷',
                  '4', '5', '6', 'x',
                  '1', '2', '3', '-',
                  '0', '.', '=', '+',
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildButtons(List<String> buttons) {
    return buttons.map((btn) {
      return ElevatedButton(
        onPressed: () {
          if (btn == '=') {
            calculateResult();
          } else if (btn == 'C') {
            clearInput();
          } else if (btn == '⌫') {
            deleteLast();
          } else if (btn == 'sin' || btn == 'cos' || btn == 'tan') {
            addTrigFunction(btn);
          } else {
            appendInput(btn);
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: const Color(0xFFD7CCC8),
          foregroundColor: const Color(0xFF5D4037),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 6,
        ),
        child: Text(
          btn,
          style: const TextStyle(fontSize: 22, color: Color(0xFF5D4037)),
        ),
      );
    }).toList();
  }
}

class CalculatorShapesPageWithDrawer extends StatelessWidget {
  const CalculatorShapesPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Bangun Ruang')),
      drawer: const GlobalDrawer(currentPage: 'CalculatorShapesPage'),
      body: const CalculatorShapesPage(),
    );
  }
}

class CurrencyCalculatorPageWithDrawer extends StatelessWidget {
  const CurrencyCalculatorPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Mata Uang')),
      drawer: const GlobalDrawer(currentPage: 'CurrencyCalculatorPage'),
      body: const CurrencyCalculatorPage(),
    );
  }
}

class CalculatorTipsPageWithDrawer extends StatelessWidget {
  const CalculatorTipsPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Tips')),
      drawer: const GlobalDrawer(currentPage: 'CalculatorTipsPage'),
      body: const CalculatorTipsPage(),
    );
  }
}

class TemperatureCalculatorPageWithDrawer extends StatelessWidget {
  const TemperatureCalculatorPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Temperatur')),
      drawer: const GlobalDrawer(currentPage: 'TemperatureCalculatorPage'),
      body: const TemperatureCalculatorPage(),
    );
  }
}

class WeightConverterPageWithDrawer extends StatelessWidget {
  const WeightConverterPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Berat')),
      drawer: const GlobalDrawer(currentPage: 'WeightConverterPage'),
      body: const WeightConverterPage(), // Halaman utama konversi berat
    );
  }
}


class FriendsPageWithDrawer extends StatelessWidget {
  const FriendsPageWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buku Telepon')),
      drawer: const GlobalDrawer(currentPage: 'FriendsPage'),
      body: const FriendsPage(),
    );
  }
}
