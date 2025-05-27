import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _serverUrlController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get _isFormFilled =>
      _serverUrlController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.apps, size: 48, color: Colors.blue),
                    Text("dhis2", style: TextStyle(color: Colors.blue, fontSize: 24)),
                    Text("v3.1.1.1 : d496710a2", style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
              SizedBox(height: 40),
              _buildTextField("Server url", _serverUrlController, Icons.link),
              SizedBox(height: 16),
              _buildTextField("Username", _usernameController, Icons.person),
              SizedBox(height: 16),
              _buildPasswordField(),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // handle account recovery
                  },
                  child: Text("Account recovery"),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isFormFilled ? () {} : null,
                child: Text("LOG IN"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48), // full width square
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {
                    // handle manage accounts
                  },
                  child: Text("Manage Accounts"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon),
        border: InputBorder.none, // removes border
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
