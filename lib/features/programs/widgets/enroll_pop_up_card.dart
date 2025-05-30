import 'package:flutter/material.dart';

void showVitalsPopupMenu(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => const VitalsPopupMenu(),
  );
}

class VitalsPopupMenu extends StatelessWidget {
  const VitalsPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _menuItem(Icons.refresh, "Refresh this record", () {
            // Handle refresh
            Navigator.pop(context);
          }),
          _menuItem(Icons.flag, "Mark for follow-up", () {
            // Handle follow-up
            Navigator.pop(context);
          }),
          _menuItem(Icons.timeline, "View timeline", () {
            // Handle timeline
            Navigator.pop(context);
          }),
          _menuItem(Icons.help_outline, "Show help", () {
            // Handle help
            Navigator.pop(context);
          }),
          _menuItem(Icons.list_alt, "More enrollments", () {
            // Handle more enrollments
            Navigator.pop(context);
          }),
          _menuItem(Icons.share, "Share", () {
            // Handle share
            Navigator.pop(context);
          }),
          const Divider(),
          _menuItem(Icons.check_circle, "Complete", () {
            // Handle complete
            Navigator.pop(context);
          }, iconColor: Colors.green),
          _menuItem(Icons.cancel, "Deactivate", () {
            // Handle deactivate
            Navigator.pop(context);
          }, iconColor: Colors.grey),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, VoidCallback onTap, {Color? iconColor}) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.blue),
      title: Text(title),
      onTap: onTap,
    );
  }
}
