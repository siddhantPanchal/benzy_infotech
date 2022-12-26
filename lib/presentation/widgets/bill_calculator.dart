import 'package:flutter/material.dart';

import '../../model/breakfast_enum.dart';
import '../../model/report.dart';


extension on String {
  String titlize() {
    return this[0].toUpperCase() + substring(1);
  }
}

class BillCalculator extends StatelessWidget {
  final Report event;

  const BillCalculator({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.breakfast_dining),
              title: Text(
                '${event.optIns?.breakfast.name}'.titlize(),
              ),
              trailing: event.optIns?.breakfast == Breakfast.pending
                  ? const Text('\$100')
                  : const Text('No Fine'),
            ),
            ListTile(
              leading: const Icon(Icons.lunch_dining),
              title: Text(
                '${event.optIns?.lunch.name}'.titlize(),
              ),
              trailing: event.optIns?.lunch == Breakfast.pending
                  ? const Text('\$100')
                  : const Text('No Fine'),
            ),
            ListTile(
              leading: const Icon(Icons.dinner_dining),
              title: Text(
                '${event.optIns?.dinner.name}'.titlize(),
              ),
              trailing: event.optIns?.dinner == Breakfast.pending
                  ? const Text('\$100')
                  : const Text('No Fine'),
            ),
            ListTile(
              tileColor: Colors.amber,
              title: const Text(
                'Total Fines',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '\$${event.fine}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
