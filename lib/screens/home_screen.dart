import 'package:flutter/material.dart';
import 'package:register_screen/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'email': 'email',
      'password': 'password',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
                CustomInputField(
                  textInputType: TextInputType.emailAddress,
                  hintText: "Correo del usuario",
                  labelText: "Correo",
                  formProperty: 'email',
                  formValues: formValues,
                  isEmail: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomInputField(
                  isPassword: true,
                  hintText: "Contraseña del usuario",
                  labelText: "Contraseña",
                  formProperty: 'password',
                  formValues: formValues,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (!myFormKey.currentState!.validate()) {
                      print("Formulario no válido");
                      return;
                    }

                    print(formValues);
                  },
                  child: const Center(
                    child: SizedBox(
                      child: Text('Guardar'),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'Register');
                    },
                    child: Text('¿Desea registrarse?'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
