import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    String firstName = nameController.text;
    String lastName = surnameController.text;
    String newFileName = '$firstName $lastName${extension(imageFile.path)}';

    //final uri = Uri.parse('http://10.0.2.2:5000/upload');
    final uri = Uri.parse('http://192.168.43.63:5600/upload');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      filename: newFileName,
    ));

    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Image envoyée avec succès!",
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Erreur lors de l'envoi de l'image",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty || _image == null) {
      Fluttertoast.showToast(
        msg: "Veuillez remplir tous les champs et ajouter une photo",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      // Création du compte Firebase
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Upload de l'image
      await _uploadImage(_image!);

      Fluttertoast.showToast(
        msg: "Compte créé avec succès!",
        backgroundColor: Colors.green,
      );
      navigatorKey.currentState?.pushReplacementNamed('/');
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Échec de l'inscription";
      if (e.code == 'email-already-in-use') {
        errorMessage = "Cet email est déjà utilisé.";
      } else if (e.code == 'weak-password') {
        errorMessage = "Mot de passe trop faible.";
      } else {
        errorMessage = e.message ?? "Erreur inconnue.";
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            SizedBox(height: 20),
            Text(
              'Rejoignez Kidway!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.yellow[800]),
            ),
            SizedBox(height: 10),
            Text(
              'Inscrivez-vous pour accéder à nos services de bus',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            _buildTextField(emailController, "Email", Icons.email),
            _buildTextField(passwordController, "Mot de passe", Icons.lock, obscureText: true),
            _buildTextField(nameController, "Prénom", Icons.person),
            _buildTextField(surnameController, "Nom", Icons.person_add),
            SizedBox(height: 20),
            _image != null
                ? Image.file(_image!, height: 150)
                : Text('Aucune image sélectionnée', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera_alt, color: Colors.white),
              label: Text('Choisir une photo', style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[800],
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _signUp,
              icon: Icon(Icons.directions_bus, color: Colors.white),
              label: Text('Créer un compte', style: TextStyle(fontSize: 18, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[800],
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 5,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vous avez déjà un compte ?", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  child: Text(
                    'Se connecter',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.yellow[800]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.yellow[800]!, width: 2),
          ),
        ),
      ),
    );
  }
}