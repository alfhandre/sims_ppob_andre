import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/card_saldo.dart';
import 'package:sims_ppob_andre/widget/card_transaksi.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      "invoice_number": "INV17082023-001",
      "transaction_type": "TOPUP",
      "description": "Top Up balance",
      "total_amount": 100000,
      "created_on": "2023-08-17T10:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-002",
      "transaction_type": "PAYMENT",
      "description": "PLN Pascabayar",
      "total_amount": 10000,
      "created_on": "2023-08-17T11:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-003",
      "transaction_type": "PAYMENT",
      "description": "Pulsa Indosat",
      "total_amount": 40000,
      "created_on": "2023-08-17T12:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-004",
      "transaction_type": "TOPUP",
      "description": "Top Up balance",
      "total_amount": 200000,
      "created_on": "2023-08-18T10:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-005",
      "transaction_type": "PAYMENT",
      "description": "Internet Paket",
      "total_amount": 30000,
      "created_on": "2023-08-18T11:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-006",
      "transaction_type": "PAYMENT",
      "description": "PLN Pascabayar",
      "total_amount": 25000,
      "created_on": "2023-08-19T10:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-007",
      "transaction_type": "TOPUP",
      "description": "Top Up balance",
      "total_amount": 50000,
      "created_on": "2023-08-19T11:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-008",
      "transaction_type": "PAYMENT",
      "description": "Pulsa Telkomsel",
      "total_amount": 15000,
      "created_on": "2023-08-20T10:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-009",
      "transaction_type": "PAYMENT",
      "description": "PLN Pascabayar",
      "total_amount": 20000,
      "created_on": "2023-08-20T11:10:10.000Z"
    },
    {
      "invoice_number": "INV17082023-010",
      "transaction_type": "PAYMENT",
      "description": "Pulsa XL",
      "total_amount": 35000,
      "created_on": "2023-08-20T12:10:10.000Z"
    },
  ];

  int visibleItemCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Roboto.bold(text: 'Transaksi', fontSize: 14),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: defaultMargin),
          child: Column(
            children: [
              SaldoCard(
                viewSaldo: false,
                saldo: 1000,
                isSaldoVisible: true,
                onToggleVisibility: () {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              historyTransaction(),
              if (visibleItemCount < transactions.length)
                TextButton(
                  onPressed: () {
                    setState(() {
                      visibleItemCount += 5;
                    });
                  },
                  child: Roboto.bold(
                      text: 'Show More', fontSize: 14, color: primaryColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyTransaction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Roboto.bold(text: 'Transaksi', fontSize: 14),
        const SizedBox(height: 16),
        transactions.isEmpty
            ? Center(
                child: Roboto.regular(
                    text: 'Maaf tidak ada transaksi saat ini',
                    fontSize: 14,
                    color: Colors.grey),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleItemCount > transactions.length
                    ? transactions.length
                    : visibleItemCount,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final dateTime = DateTime.parse(transaction["created_on"]);
                  final formattedDate =
                      DateFormat('dd MMM yyyy, HH:mm').format(dateTime);

                  return TransactionCard(
                      amount:
                          'Rp. ${formatCurrency(transaction["total_amount"])}',
                      title: transaction["description"],
                      date: '${formattedDate} WIB',
                      transaction_type: transaction['transaction_type']);
                },
              ),
      ],
    );
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }
}
