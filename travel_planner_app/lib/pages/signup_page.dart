import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  void signup() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text;
    final username = usernameController.text.trim(); // Get username

    try {
      setState(() => isLoading = true);

      // Create user
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Update displayName
      await _auth.currentUser?.updateDisplayName(username);

      // Reload user to update profile
      await _auth.currentUser?.reload();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful! Please login.')),
      );

      Navigator.pop(context); // Go back to login page
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Signup failed';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already registered.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password should be at least 6 characters.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text("Sign up", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Create an account, It's free", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
                SizedBox(height: 30),
                inputField(label: "Username", controller: usernameController, validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Enter a username';
                  return null;
                }),
                inputField(label: "Email", controller: emailController, isEmail: true, validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Enter an email';
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) return 'Enter a valid email';
                  return null;
                }),
                inputField(label: "Password", controller: passwordController, obscureText: true, validator: (val) {
                  if (val == null || val.isEmpty) return 'Enter password';
                  if (val.length < 6) return 'Password must be at least 6 characters';
                  return null;
                }),
                inputField(label: "Confirm Password", controller: confirmPasswordController, obscureText: true, validator: (val) {
                  if (val != passwordController.text) return "Passwords don't match";
                  return null;
                }),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: signup,
                  color: Color(0xff0095FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(" Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    bool isEmail = false,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
