import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:sims_ppob_andre/screen/auth/login_screen.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/custom_button.dart';
import 'package:sims_ppob_andre/widget/snackbar.dart';
import 'package:sims_ppob_andre/widget/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaDepanController = TextEditingController();
  final TextEditingController namaBelakangController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isEmailError = false;
  bool isNamaDepanError = false;
  bool isNamaBelakangError = false;
  bool isConfirmPasswordError = false;
  bool isPasswordError = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        isLoading: isLoading,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    logo(),
                    const SizedBox(height: 24),
                    header(),
                    const SizedBox(height: 24),
                    formBody(),
                    const SizedBox(height: 24),
                    registerButton(),
                    const SizedBox(height: 16),
                    textToLogin(),
                  ]),
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
            text: 'Lengkapi data untuk\nmembuat akun',
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
          hintText: 'masukan email anda',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.alternate_email),
          isError: isEmailError,
          validator: (value) {
            return _validateField(value, validateEmail);
          },
        ),
        const SizedBox(height: 18),
        CustomTextField(
          controller: namaDepanController,
          hintText: 'masukan nama depan',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.person_outline),
          isError: isNamaDepanError,
          validator: (value) {
            return _validateField(value, validateConfirmNamaDepan);
          },
        ),
        const SizedBox(height: 18),
        CustomTextField(
          controller: namaBelakangController,
          hintText: 'masukan nama belakang',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.person_outline),
          isError: isNamaBelakangError,
          validator: (value) {
            return _validateField(value, validateConfirmNamaBelakang);
          },
        ),
        const SizedBox(height: 18),
        CustomTextField(
          controller: passwordController,
          hintText: 'buat password',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.lock_rounded),
          isPassword: true,
          isError: isPasswordError,
          validator: (value) {
            return _validateField(value, validatePassword);
          },
        ),
        const SizedBox(height: 18),
        CustomTextField(
          controller: confirmPasswordController,
          hintText: 'konfirmasi passrwod',
          hintStyle: hintTextStyle,
          prefixIcon: const Icon(Icons.lock_rounded),
          isPassword: true,
          isError: isConfirmPasswordError,
          validator: (value) {
            return _validateField(value, validateConfirmPassword);
          },
        ),
      ],
    );
  }

  Widget registerButton() {
    return CustomButton(onPressed: onRegsiterPressed, text: 'Registrasi');
  }

  Widget textToLogin() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Roboto.light(text: 'Sudah punya akun? Login ', fontSize: 14),
          GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
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

  void onRegsiterPressed() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        showCustomSnackBar(context, 'Register berhasil', Colors.green);
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != passwordController.text) {
      return 'Password tidak sama';
    }
    return null;
  }

  String? validateConfirmNamaDepan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama Depan tidak boleh kosong';
    }
    return null;
  }

  String? validateConfirmNamaBelakang(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama Belakang tidak boleh kosong';
    }
    return null;
  }
}
