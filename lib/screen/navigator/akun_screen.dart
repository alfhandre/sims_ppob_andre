import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_andre/providers/auth_provider.dart';
import 'package:sims_ppob_andre/screen/auth/login_screen.dart';
import 'package:sims_ppob_andre/theme.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';
import 'package:sims_ppob_andre/widget/custom_button.dart';
import 'package:sims_ppob_andre/widget/text_field.dart';
import 'package:sims_ppob_andre/widget/snackbar.dart';

class AkunScreen extends StatefulWidget {
  const AkunScreen({super.key});

  @override
  State<AkunScreen> createState() => _AkunScreenState();
}

class _AkunScreenState extends State<AkunScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController namaDepanController = TextEditingController();
  final TextEditingController namaBelakangController = TextEditingController();

  bool isEditMode = true;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  void toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final extension = pickedFile.path.split('.').last.toLowerCase();
      if (extension == 'jpeg' || extension == 'jpg' || extension == 'png') {
        setState(() {
          _imageFile = File(pickedFile.path);
          print(_imageFile);
        });
      } else {
        CustomSnackBar.show(
          context,
          'Format file tidak sesuai. Harus JPEG atau PNG.',
          Colors.red,
          Colors.white,
        );
      }
    }
  }

  void printEditData() {
    String firstName = namaDepanController.text;
    String lastName = namaBelakangController.text;

    String fileType =
        _imageFile != null ? _imageFile!.path.split('.').last : '';
    int fileSize = _imageFile != null
        ? _imageFile!.lengthSync()
        : 0; // Getting file size in bytes

    print('''
    {
      "first_name": "$firstName",
      "last_name": "$lastName",
      "file": {
        "path": "${_imageFile?.path ?? ''}",
        "type": "$fileType",
        "size": $fileSize
      }
    }
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Roboto.bold(text: 'Akun', fontSize: 14),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
            child: Column(
              children: [
                buildProfileImage(),
                const SizedBox(height: 16),
                buildTextField(emailController, 'Email', 'Masukkan email anda',
                    const Icon(Icons.alternate_email)),
                const SizedBox(height: 16),
                buildTextField(
                    namaDepanController,
                    'Nama Depan',
                    'Masukkan nama depan anda',
                    const Icon(Icons.person_2_outlined)),
                const SizedBox(height: 16),
                buildTextField(
                    namaBelakangController,
                    'Nama Belakang',
                    'Masukkan nama belakang anda',
                    const Icon(Icons.person_2_outlined)),
                const SizedBox(height: 16),
                buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage() {
    return GestureDetector(
      onTap: () {
        if (!isEditMode) pickImage();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : const AssetImage('assets/pictures/Profile Photo-1.png')
                    as ImageProvider,
          ),
          if (!isEditMode) ...[
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: 0.5,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.edit,
                    color: Colors.black87,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String labelText,
      String hintText, Icon prefixIcon) {
    return CustomTextFieldLabel(
      enabled: !isEditMode,
      controller: controller,
      hintText: hintText,
      hintStyle: hintTextStyle,
      prefixIcon: prefixIcon,
      labelText: labelText,
    );
  }

  Widget buildActionButtons() {
    final authProvider = Provider.of<AuthProvider>(context);

    return Column(
      children: [
        isEditMode
            ? CustomButton(
                onPressed: toggleEditMode,
                text: 'Edit Profil',
              )
            : CustomButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  printEditData();
                },
                text: 'Simpan',
              ),
        const SizedBox(height: 8),
        isEditMode
            ? CustomButtonBorder(
                onPressed: () async {
                  await authProvider.logout();

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                text: 'Logout',
              )
            : CustomButtonBorder(
                onPressed: toggleEditMode,
                text: 'Batalkan',
              ),
      ],
    );
  }
}
