import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/card_saldo.dart';
import 'package:sims_ppob_andre/widget/custom_button.dart';
import 'package:sims_ppob_andre/widget/text_field.dart';

class TopupScreen extends StatefulWidget {
  const TopupScreen({super.key});

  @override
  State<TopupScreen> createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  TextEditingController topUpAmountController = TextEditingController();

  String formatCurrency(int amount) {
    return 'Rp. ${amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Roboto.bold(text: 'Top Up', fontSize: 14),
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
              saldo: 0,
              isSaldoVisible: true,
              onToggleVisibility: () {
                setState(() {});
              },
            ),
            const SizedBox(height: 32),
            Roboto.regular(text: 'Silahkan masukan', fontSize: 16),
            Roboto.bold(text: 'nominal Top Up', fontSize: 18),
            const SizedBox(height: 32),
            CustomTextField(
              keyboardType: TextInputType.number,
              controller: topUpAmountController,
              hintText: 'masukan nominal Top Up',
              hintStyle: hintTextStyle,
              prefixIcon: const Icon(Icons.money),
            ),
            const SizedBox(height: 16),
            _buildCurrencySelectionRow(
                ['Rp. 10.000', 'Rp. 20.000', 'Rp. 50.000']),
            const SizedBox(height: 16),
            _buildCurrencySelectionRow(
                ['Rp. 100.000', 'Rp. 250.000', 'Rp. 500.000']),
            const SizedBox(height: 32),
            CustomButton(
                onPressed: () {
                  try {
                    String cleanText = topUpAmountController.text
                        .replaceAll('Rp. ', '')
                        .replaceAll('.', '');
                    int value = int.parse(cleanText);
                    print("Parsed integer value: $value");
                  } catch (e) {
                    print("Invalid input, not an integer");
                  }
                },
                text: 'Top Up')
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelectionRow(List<String> amounts) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: amounts.map((amount) {
        int amountValue = int.parse(
          amount.replaceAll('Rp. ', '').replaceAll('.', ''),
        );
        return CurrencyButton(
          amount: formatCurrency(amountValue),
          onTap: () {
            setState(() {
              topUpAmountController.text = amountValue.toString();
            });
          },
        );
      }).toList(),
    );
  }
}

class CurrencyButton extends StatelessWidget {
  final String amount;
  final VoidCallback onTap;

  const CurrencyButton({Key? key, required this.amount, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Center(
          child: Roboto.light(text: amount, fontSize: 14),
        ),
      ),
    );
  }
}
