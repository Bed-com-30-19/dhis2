import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth_library.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _urlController = TextEditingController();
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
                  child: const Column(
                    children: [
                      Icon(Icons.apps, size: 48, color: Colors.white),
                      Text("dhis2", style: TextStyle(color: Colors.white, fontSize: 24)),
                      Text("v3.1.1.1 : d496710a2", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildTextField("URL", _urlController, Icons.person),
                      const SizedBox(height: 16),
                      _buildTextField("Username", _usernameController, Icons.person),
                      const SizedBox(height: 16),
                      _buildPasswordField(),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle account recovery
                          },
                          child: const Text("Account recovery"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isFormFilled && !viewModel.isLoading
                            ? () async {
                                await viewModel.login(
                                  _urlController.text,
                                  _usernameController.text,
                                  _passwordController.text,
                                  (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)),
                                    );
                                  },
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        child: const Text("LOG IN"),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Handle manage accounts
                        },
                        child: const Text("Manage Accounts"),
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
