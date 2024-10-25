import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';

class SaldoCard extends StatelessWidget {
  final int saldo;
  final bool isSaldoVisible;
  final VoidCallback onToggleVisibility;
  final bool viewSaldo;

  const SaldoCard({
    Key? key,
    required this.saldo,
    required this.isSaldoVisible,
    required this.onToggleVisibility,
    required this.viewSaldo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(colors: [Colors.red, Colors.red[900]!]),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Roboto.regular(
                text: 'Saldo anda', fontSize: 16, color: Colors.white),
            const SizedBox(height: 8),
            Roboto.bold(
              text: isSaldoVisible ? 'Rp. ${formatCurrency(saldo)}' : '•••••••',
              fontSize: 28,
              color: Colors.white,
            ),
            viewSaldo
                ? Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Roboto.regular(
                            text: 'Lihat Saldo',
                            fontSize: 14,
                            color: Colors.white),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: onToggleVisibility,
                          child: Icon(
                            isSaldoVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(amount).replaceAll(',', '.');
  }
}
