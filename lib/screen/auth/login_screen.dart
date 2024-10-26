import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sims_ppob_andre/exception/auth_exception.dart';
import 'package:sims_ppob_andre/screen/auth/register_screen.dart';
import 'package:sims_ppob_andre/screen/navigator/navigator.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/custom_button.dart';
import 'package:sims_ppob_andre/widget/snackbar.dart';
import 'package:sims_ppob_andre/widget/text_field.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_andre/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEmailError = false;
  bool isPasswordError = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      logo(),
                      const SizedBox(height: 24),
                      header(),
                      const SizedBox(height: 24),
                      formBody(),
                      const SizedBox(height: 18),
                      loginButton(),
                      const SizedBox(height: 16),
                      textToRegister(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/pictures/Logo.png', width: 28),
        const SizedBox(width: 8),
        Roboto.bold(text: 'SIMS PPOB', fontSize: 21),
      ],
    );
  }

  Widget header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Roboto.bold(
            text: 'Masuk atau buat akun\nuntuk memulai',
            fontSize: 21,
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget formBody() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: 'Email',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.alternate_email),
          isError: isEmailError,
          validator: (value) {
            return _validateField(value, validateEmail);
          },
        ),
        const SizedBox(height: 18),
        CustomTextField(
          controller: passwordController,
          hintText: 'Password',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.lock_rounded),
          isPassword: true,
          isError: isPasswordError,
          validator: (value) {
            return _validateField(value, validatePassword);
          },
        ),
      ],
    );
  }

  Widget loginButton() {
    return CustomButton(onPressed: onLoginPressed, text: 'Masuk');
  }

  Widget textToRegister() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Roboto.light(text: 'Belum punya akun? Registrasi ', fontSize: 14),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
              child: Roboto.bold(
                  text: 'di sini', fontSize: 14, color: primaryColor))
        ]);
  }

  void showCustomSnackBar(
      BuildContext context, String message, Color textColor) {
    CustomSnackBar.show(
      context,
      message,
      backgroundColorSnackbar,
      textColor,
    );
  }

  String? _validateField(String? value, Function validator) {
    String? validationMessage = validator(value);
    if (validationMessage != null) {
      showCustomSnackBar(context, validationMessage, primaryColor);
    }
    return validationMessage;
  }

  void onLoginPressed() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(context, listen: false).login(
          emailController.text,
          passwordController.text,
        );
        showCustomSnackBar(context, 'Login berhasil', Colors.green);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const NavigatorPage(id: 0)));
      } on AuthException catch (e) {
        showCustomSnackBar(context, e.message, Colors.red);
      } catch (e) {
        print('Error: $e');
        showCustomSnackBar(context, 'An unexpected error occurred', Colors.red);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Masukkan format email yang benar';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password harus minimal 8 karakter';
    }
    return null;
  }
}
