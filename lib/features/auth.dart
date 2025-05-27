import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get _isFormFilled =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue[700],
              padding: EdgeInsets.symmetric(vertical: 24),
              width: double.infinity,
              child: Column(
                children: [
                  Icon(Icons.apps, size: 48, color: Colors.white),
                  Text("dhis2", style: TextStyle(color: Colors.white, fontSize: 24)),
                  Text("v3.1.1.1 : d496710a2", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildReadOnlyField("https://project.ccdev.org/ictproject"),
                  SizedBox(height: 16),
                  _buildTextField("Username", _usernameController, Icons.person),
                  SizedBox(height: 16),
                  _buildPasswordField(),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle account recovery
                      },
                      child: Text("Account recovery"),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isFormFilled ? () {
                      // Handle login
                    } : null,
                    child: Text("LOG IN"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Handle manage accounts
                    },
                    child: Text("Manage Accounts"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String value) {
    return TextField(
      controller: TextEditingController(text: value),
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Server url",
        prefixIcon: Icon(Icons.link),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() {
            _obscurePassword = !_obscurePassword;
          }),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
