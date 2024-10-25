import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String title;
  final String date;
  final String transaction_type;
  final Color amountColor;

  const TransactionCard({
    Key? key,
    required this.amount,
    required this.title,
    required this.date,
    this.amountColor = const Color(0xff00A980),
    required this.transaction_type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(255, 210, 210, 210), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Roboto.regular(
                  text: transaction_type == 'TOPUP' ? '+ $amount' : '- $amount',
                  fontSize: 18,
                  color: transaction_type == 'TOPUP'
                      ? const Color(0xff00A980)
                      : Colors.red,
                ),
                Roboto.regular(text: title, fontSize: 10),
              ],
            ),
            Roboto.regular(text: date, fontSize: 10, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
