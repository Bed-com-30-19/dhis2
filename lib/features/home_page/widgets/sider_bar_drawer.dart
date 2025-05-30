import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  final String username;

  const SidebarDrawer({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF0288D1),
            ),
            child: Row(
              children: [
                const Icon(Icons.layers, size: 40, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('dhis2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                      Text(
                        username,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildListTile(context, Icons.home, "Home", () {}),
          _buildListTile(context, Icons.qr_code, "Import QR data", () {}),
          _buildListTile(context, Icons.settings, "Settings", () {}),
          _buildListTile(context, Icons.lock, "Set pin", () {}),
          _buildListTile(context, Icons.logout, "Log Out", () {}),
          const Divider(),
          _buildListTile(context, Icons.build, "Configuration troubleshooting", () {}),
          _buildListTile(context, Icons.info_outline, "About", () {}),
          const Spacer(),
          _buildListTile(context, Icons.delete_forever, "Delete Account", () {}, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.grey[700]),
      title: Text(title, style: TextStyle(color: color ?? Colors.black)),
      onTap: onTap,
    );
  }
}
