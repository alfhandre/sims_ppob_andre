import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/models/service_model.dart';
import 'package:sims_ppob_andre/screen/navigator/navigator.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';

class CustomAlertDialog extends StatelessWidget {
  final ServiceModel service;
  final bool status;
  const CustomAlertDialog(
      {super.key, required this.service, this.status = true});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(status ? Icons.check_circle : Icons.cancel,
                  color: status ? Colors.green : Colors.red, size: 86),
              const SizedBox(height: 16),
              Roboto.regular(
                  textAlign: TextAlign.center,
                  text: 'Pembayaran ${service.serviceName} sebesar',
                  fontSize: 12),
              Roboto.bold(
                  textAlign: TextAlign.center,
                  text: 'Rp. ${service.serviceTariff}',
                  fontSize: 24),
              Roboto.regular(
                  textAlign: TextAlign.center,
                  text: status ? 'berhasil!' : 'gagal',
                  fontSize: 12),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavigatorPage(id: 0)));
                },
                child: Roboto.bold(
                    textAlign: TextAlign.center,
                    text: 'Kembali ke beranda',
                    fontSize: 14,
                    color: primaryColor),
              ),
            ]),
      ),
    );
  }
}

class AlertDialogPayment extends StatelessWidget {
  final ServiceModel service;
  final bool status;
  final void Function() onPressed;
  const AlertDialogPayment(
      {super.key,
      required this.service,
      this.status = true,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(service.serviceIcon),
              const SizedBox(height: 16),
              Roboto.regular(
                  textAlign: TextAlign.center,
                  text: 'Beli ${service.serviceName} senilai',
                  fontSize: 12),
              Roboto.bold(
                  textAlign: TextAlign.center,
                  text: 'Rp. ${service.serviceTariff} ?',
                  fontSize: 24),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onPressed,
                child: Roboto.bold(
                    textAlign: TextAlign.center,
                    text: 'Ya, lanjutkan bayar',
                    fontSize: 14,
                    color: primaryColor),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Roboto.bold(
                    textAlign: TextAlign.center,
                    text: 'Batalkan',
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ]),
      ),
    );
  }
}
