import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth_library.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _urlController = TextEditingController(text: 'https://project.ccdev.org/ictprojects');
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  bool get _isFormFilled =>
      _urlController.text.isNotEmpty &&
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.apps, size: 48, color: Colors.white),
                          SizedBox(width: 8),
                          Text("dhis2", style: TextStyle(color: Colors.white, fontSize: 24)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 24.0, top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("v3.1.1.1 : d496710a2", style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildTextField("Server URL", _urlController, Icons.link),
                        const SizedBox(height: 16),
                        _buildTextField("Username", _usernameController, Icons.person),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 8),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Handle account recovery
                            },
                            child: const Text(
                              "Account recovery",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        if (viewModel.errorMessage != null) 
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _isFormFilled && !viewModel.isLoading
                            ? () => _handleLogin(viewModel)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormFilled ? Colors.blue : null,
                          minimumSize: const Size(double.infinity, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text("LOG IN"),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home-page');
                        },
                        child: const Text(
                          "Manage Accounts",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (viewModel.isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: label,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Row(
      children: [
        const Icon(Icons.lock, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: "Password",
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() {
                  _obscurePassword = !_obscurePassword;
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin(LoginViewModel viewModel) async {
    await viewModel.login(
      _urlController.text,
      _usernameController.text,
      _passwordController.text,
    );

    if (viewModel.errorMessage == null && viewModel.loginSuccess) {
      Navigator.pushReplacementNamed(context, '/home-page');
    } else if (viewModel.errorMessage != null) {
      debugPrint('Login failed: ${viewModel.errorMessage}');
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}