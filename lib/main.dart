import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF2F7FC),
        fontFamily: 'Roboto',
      ),
      home: const SalaryCalculator(),
    );
  }
}

class SalaryCalculator extends StatefulWidget {
  const SalaryCalculator({super.key});

  @override
  State<SalaryCalculator> createState() => _SalaryCalculatorState();
}

class _SalaryCalculatorState extends State<SalaryCalculator> {
  final TextEditingController salaryController =
  TextEditingController();

  String selectedType = 'Standard';

  double netSalary = 0;
  double tax = 0;

  void calculateSalary() {
    double grossSalary =
        double.tryParse(salaryController.text) ?? 0;

    double taxPercent;

    if (selectedType == 'Standard') {
      taxPercent = 0.12;
    } else if (selectedType == 'Redus') {
      taxPercent = 0.08;
    } else {
      taxPercent = 0.20;
    }

    setState(() {
      tax = grossSalary * taxPercent;
      netSalary = grossSalary - tax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Calculator salariu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Titlu
            const Text(
              'Calculează salariul net',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D47A1),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Introdu salariul brut și selectează tipul de impozitare.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // Card salariu brut
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          color: Color(0xFF1565C0),
                          size: 26,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Salariu brut',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: salaryController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFBBDEFB),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1565C0),
                            width: 2,
                          ),
                        ),
                        labelText: 'Introduceți salariul brut',
                        suffixText: 'lei',
                        prefixIcon: const Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Card tip impozitare
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [
                        Icon(
                          Icons.percent,
                          color: Color(0xFF1565C0),
                          size: 26,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Tipul de impozitare',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    DropdownButton<String>(
                      value: selectedType,
                      isExpanded: true,

                      items: const [
                        DropdownMenuItem(
                          value: 'Standard',
                          child: Text('Standard - 12%'),
                        ),

                        DropdownMenuItem(
                          value: 'Redus',
                          child: Text('Redus - 8%'),
                        ),

                        DropdownMenuItem(
                          value: 'Special',
                          child: Text('Special - 20%'),
                        ),
                      ],

                      onChanged: (String? newValue) {
                        setState(() {
                          selectedType = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Buton
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: calculateSalary,
                icon: const Icon(
                  Icons.calculate,
                  color: Colors.white,
                ),
                label: const Text(
                  'Calculează salariul',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

           
            Card(
              elevation: 3,
              color: const Color(0xFFE3F2FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Text(
                      'Rezultatul calculului',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D47A1),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Color(0xFF1565C0),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Impozit:',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '${tax.toStringAsFixed(2)} lei',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 30),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet,
                              color: Color(0xFF1565C0),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Salariu net:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          '${netSalary.toStringAsFixed(2)} lei',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}