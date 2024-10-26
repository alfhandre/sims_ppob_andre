import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_andre/providers/balance_provider.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/alert_dialog.dart';
import 'package:sims_ppob_andre/widget/card_saldo.dart';
import 'package:sims_ppob_andre/models/service_model.dart';
import 'package:sims_ppob_andre/widget/custom_button.dart';

class PembayaranScreen extends StatefulWidget {
  final ServiceModel service;
  final int? saldo;

  const PembayaranScreen({super.key, required this.service, this.saldo});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Roboto.bold(text: 'Pembayaran', fontSize: 14),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SaldoCard(
              viewSaldo: false,
              saldo: widget.saldo ?? 0,
              isSaldoVisible: true,
              onToggleVisibility: () {
                setState(() {});
              },
            ),
            const SizedBox(height: 48),
            Roboto.regular(text: 'PemBayaran', fontSize: 12),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(widget.service.serviceIcon,
                    width: 28, height: 28),
                const SizedBox(width: 8),
                Roboto.bold(text: widget.service.serviceName, fontSize: 14)
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.money, color: Colors.black, size: 16),
                  const SizedBox(width: 8),
                  Roboto.regular(
                      text: widget.service.serviceTariff.toString(),
                      fontSize: 12)
                ],
              ),
            ),
            const Spacer(),
            widget.saldo! <= widget.service.serviceTariff
                ? Center(
                    child: Roboto.bold(
                        text: 'Saldo anda tidak cukup',
                        fontSize: 14,
                        color: Colors.red))
                : CustomButton(
                    onPressed: () async {
                      final balanceProvider =
                          Provider.of<BalanceProvider>(context, listen: false);
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialogPayment(
                              service: widget.service,
                              onPressed: () async {
                                try {
                                  await balanceProvider
                                      .transaction(widget.service.serviceCode);
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomAlertDialog(
                                            service: widget.service,
                                            status: true,
                                          ));
                                } catch (e) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomAlertDialog(
                                            service: widget.service,
                                            status: false,
                                          ));
                                }
                              }));
                    },
                    text: 'Bayar')
          ],
        ),
      ),
    );
  }
}
