import 'package:flutter/material.dart';

class CarCal extends StatefulWidget {
  const CarCal({super.key});

  @override
  State<CarCal> createState() => _CarCalState();
}

class _CarCalState extends State<CarCal> {
  TextEditingController carPriceCtrl = TextEditingController();
  TextEditingController interestRateCtrl = TextEditingController();

  int downPaymentPercent = 10;
  int durationMonths = 60; // ตั้งค่าเริ่มต้นที่ 60 เดือนตามรูป
  double monthlyInstallment = 0.0;

  final List<int> monthOptions = [12, 24, 36, 48, 60, 72, 84];

  void calculateInstallment() {
    setState(() {
      double? price = double.tryParse(carPriceCtrl.text);
      double? interestRate = double.tryParse(interestRateCtrl.text);

      if (price != null && interestRate != null && price > 0) {
        double downAmount = price * (downPaymentPercent / 100);
        double financeAmount = price - downAmount;

        double years = durationMonths / 12;
        double totalInterest = financeAmount * (interestRate / 100) * years;
        double totalToPay = financeAmount + totalInterest;

        monthlyInstallment = totalToPay / durationMonths;
      } else {
        monthlyInstallment = 0.0;
      }
    });
  }

  void clearData() {
    setState(() {
      carPriceCtrl.clear();
      interestRateCtrl.clear();
      downPaymentPercent = 10;
      durationMonths = 60;
      monthlyInstallment = 0.0;
    });
  }

  String formatCurrency(double amount) {
    if (amount == 0) return "0.00";
    return amount.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFB71C1C),
                Color(0xFFD32F2F),
                Color(0xFFF44336),
                Color(0xFFFF5722),
                Color(0xFFFF9800),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: const Text(
          'CI Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'คำนวณค่างวดรถ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFF4CAF50), width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/joke.jpg',
                      width: 200,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 200,
                        height: 130,
                        color: Colors.grey[200],
                        child: const Icon(Icons.directions_car,
                            size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text('ราคารถ (บาท)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: carPriceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(height: 15),
              const Text('จำนวนเงินดาวน์ (%)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [10, 20, 30, 40, 50].map((int value) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<int>(
                        value: value,
                        groupValue: downPaymentPercent,
                        activeColor: Colors.black,
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        onChanged: (int? newValue) {
                          setState(() {
                            downPaymentPercent = newValue!;
                          });
                        },
                      ),
                      Text('$value'),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              const Text('ระยะเวลาผ่อน (เดือน)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: durationMonths,
                    isExpanded: true,
                    items: monthOptions.map((int month) {
                      return DropdownMenuItem<int>(
                        value: month,
                        child: Text('$month เดือน'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        durationMonths = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text('อัตราดอกเบี้ย (%/ปี)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: interestRateCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: '0.00',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: calculateInstallment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'คำนวณ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: clearData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  border:
                      Border.all(color: const Color(0xFF81C784), width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Text(
                      'ค่างวดรถต่อเดือนเป็นเงิน',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatCurrency(monthlyInstallment),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF44336),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'บาทต่อเดือน',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
