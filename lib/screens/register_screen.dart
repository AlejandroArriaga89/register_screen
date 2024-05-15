import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:register_screen/widgets/widgets.dart';

// Clase renombrada para evitar conflictos de nombres
class ImageSelectionProvider extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  void setImage(File file) {
    _image = file;
    notifyListeners();
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  Future<void> _getImage(BuildContext context, ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);

    if (pickedImage != null) {
      Provider.of<ImageSelectionProvider>(context, listen: false)
          .setImage(File(pickedImage.path));
    }
  }

  void _displayDialogIos(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Selecciona una foto de perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                onPressed: () => _getImage(context, ImageSource.camera),
                child: const Text('Toma una foto'),
              ),
              CupertinoButton(
                onPressed: () => _getImage(context, ImageSource.gallery),
                child: const Text('Selecciona una foto de la galería'),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'first_name': 'first_name',
      'last_name': 'last_name',
      'email': 'email',
      'password': 'password',
      'role': 'Admin',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Form(
            key: myFormKey,
            child: Column(
              children: [
                Consumer<ImageSelectionProvider>(
                  builder: (context, imageProvider, _) {
                    return IconButton(
                      icon: imageProvider.image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: FileImage(imageProvider.image!),
                            )
                          : const Icon(
                              Icons.person,
                              size: 100,
                            ),
                      onPressed: () {
                        _displayDialogIos(context);
                      },
                    );
                  },
                ),
                // Otros campos del formulario
                CustomInputField(
                  hintText: "Nombre del usuario",
                  labelText: "Nombre",
                  formProperty: 'first_name',
                  formValues: formValues,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  hintText: "Apellido del usuario",
                  labelText: "Apellido",
                  formProperty: 'last_name',
                  formValues: formValues,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  isEmail: true,
                  textInputType: TextInputType.emailAddress,
                  hintText: "Correo del usuario",
                  labelText: "Correo",
                  formProperty: 'email',
                  formValues: formValues,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  isPassword: true,
                  hintText: "Contraseña del usuario",
                  labelText: "Contraseña",
                  formProperty: 'password',
                  formValues: formValues,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!myFormKey.currentState!.validate()) {
                      print("Formulario no válido");
                      return;
                    }
                    // Guardar datos del formulario
                    print(formValues);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
