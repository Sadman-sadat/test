import 'package:flutter/material.dart';
import 'package:temp/controller/age_calculator_controller.dart';
import 'package:get/get.dart';

class AgeCalculatorScreen extends StatelessWidget {
   AgeCalculatorScreen({super.key});

  final AgeCalculatorController ageCalculatorController = Get.put(AgeCalculatorController());

  Future<void> pickBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
    );
    if (picked != null) {
      ageCalculatorController.setBirthDate(picked);
    }
  }

  Future<void> pickCalculateDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ageCalculatorController.setBirthDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Age Calculator"),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select your Date of birth", style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            dateCard(
              "Date of Birth",
              ageCalculatorController.birthDate,
                  () => pickBirthDate(context),
            ),
            dateCard(
              "Pick date up to which to calculate age",
              ageCalculatorController.calculateDate,
                  () => pickCalculateDate(context),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ageCalculatorController.calculateAge,
                child: const Text("Calculate"),
              ),
            ),

            resultCard()
          ],
        ),
      ),
    );
  }

   Widget dateCard(String title, Rx<DateTime?> date, VoidCallback onTap) {

     return Card(
       elevation: 4,
       margin: const EdgeInsets.symmetric(vertical: 10),
       child: ListTile(
         leading: const Icon(Icons.calendar_today, color: Colors.deepPurple),
         title: Text(title),

         subtitle: Obx(() {

           if (date.value == null) {
             return const Text("Select Date");
           }

           final d = date.value!;
           return Text("${d.year}-${d.month}-${d.day}");
         }),

         onTap: onTap,
       ),
     );
   }

   Widget resultCard() {

     return Card(
       color: Colors.orange.shade50,
       margin: const EdgeInsets.only(top: 20),
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [

             ageItem(ageCalculatorController.years, "Years"),
             ageItem(ageCalculatorController.months, "Months"),
             ageItem(ageCalculatorController.days, "Days"),

           ],
         ),
       ),
     );
   }

   Widget ageItem(RxInt value, String label) {

     return Obx(() => Column(
       children: [
         Text(
           value.value.toString(),
           style: const TextStyle(
             fontSize: 32,
             fontWeight: FontWeight.bold,
             color: Colors.deepPurple,
           ),
         ),
         Text(label)
       ],
     ));
   }
}
// todo