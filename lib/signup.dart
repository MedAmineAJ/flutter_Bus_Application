import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  late DatabaseReference dbRef;
  bool isSending = false;

  String? selectedParentOrStudent;
  int selectedAge = 7;
  File? _selectedImage;

  final List<String> parentOrStudentOptions = ['Parent', 'Élève'];

  // ---------------- INIT ----------------
  @override
  void initState() {
    super.initState();
    final database = FirebaseDatabase.instanceFor(
      app: FirebaseDatabase.instance.app,
      databaseURL:
          "https://finalkidway-default-rtdb.europe-west1.firebasedatabase.app/",
    );
    dbRef = database.ref('users');
  }

  // ---------------- Image Picker ----------------
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // ---------------- Upload Cloudinary ----------------
  Future<String?> _uploadImageCloudinary(File file, String name, String surname) async {
    final cloudName = 'djwcuqgc6'; // ton Cloudinary cloud name
    final uploadPreset = 'profile_images'; // preset créé dans Cloudinary

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      request.fields['upload_preset'] = uploadPreset;
      request.fields['folder'] = 'Home/profile_images';
      request.fields['public_id'] = '${surname}_$name'; // Nom du fichier: prenom_nom

      var response = await request.send();
      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        var jsonResp = json.decode(respStr);
        print('URL image: ${jsonResp['secure_url']}');
        return jsonResp['secure_url'];
      } else {
        print('Erreur upload Cloudinary: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erreur Cloudinary: $e');
      return null;
    }
  }

  // ---------------- Sign Up ----------------
  Future<void> _signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final surname = surnameController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        surname.isEmpty ||
        selectedParentOrStudent == null) {
      Fluttertoast.showToast(
        msg: "Veuillez remplir tous les champs",
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() => isSending = true);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 🔹 Upload image sur Cloudinary
      String? photoUrl;
      if (_selectedImage != null) {
        photoUrl = await _uploadImageCloudinary(_selectedImage!, name, surname);
      }

      await dbRef.child(uid).set({
        'nom': name,
        'prenom': surname,
        'age': selectedAge,
        'parentOrStudent': selectedParentOrStudent,
        'email': email,
        'photoUrl': photoUrl ?? "",
        'timestamp': DateTime.now().toIso8601String(),
      });

      Fluttertoast.showToast(
        msg: "Compte créé avec succès!",
        backgroundColor: Colors.green,
      );

      navigatorKey.currentState?.pushReplacementNamed('/');

      // Reset champs
      nameController.clear();
      surnameController.clear();
      emailController.clear();
      passwordController.clear();
      setState(() {
        selectedParentOrStudent = null;
        selectedAge = 7;
        _selectedImage = null;
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? "Erreur inconnue.";
      if (e.code == 'email-already-in-use')
        errorMessage = "Cet email est déjà utilisé.";
      else if (e.code == 'weak-password')
        errorMessage = "Mot de passe trop faible.";

      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() => isSending = false);
    }
  }

  // ---------------- WIDGETS ----------------
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool obscureText = false,
  }) {
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

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Parent ou Élève",
          prefixIcon: Icon(Icons.group, color: Colors.yellow[800]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedParentOrStudent,
            hint: const Text("Choisir"),
            items: parentOrStudentOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedParentOrStudent = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAgePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Âge : $selectedAge",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 100,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                int age = index + 1;
                bool isSelected = age == selectedAge;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAge = age;
                    });
                  },
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Colors.yellow[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.yellow.withOpacity(0.5),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    child: Text(
                      "$age",
                      style: TextStyle(
                        fontSize: isSelected ? 20 : 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.yellow[800],
            backgroundImage:
                _selectedImage != null ? FileImage(_selectedImage!) : null,
            child: _selectedImage == null
                ? const Icon(Icons.camera_alt, color: Colors.white, size: 40)
                : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text("Ajouter une photo de profil"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'Rejoignez Kidway!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Inscrivez-vous pour accéder à nos services de bus',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              _buildImagePicker(),
              const SizedBox(height: 20),
              _buildTextField(emailController, "Email", Icons.email),
              _buildTextField(passwordController, "Mot de passe", Icons.lock,
                  obscureText: true),
              _buildTextField(nameController, "Prénom", Icons.person),
              _buildTextField(surnameController, "Nom", Icons.person_add),
              _buildAgePicker(),
              _buildDropdown(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: isSending ? null : _signUp,
                icon: const Icon(Icons.directions_bus, color: Colors.white),
                label: isSending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Créer un compte',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[800],
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez déjà un compte ?", style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/'),
                    child: const Text(
                      'Se connecter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
