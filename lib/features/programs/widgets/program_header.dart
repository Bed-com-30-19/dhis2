import 'package:flutter/material.dart';

class ProgramHeader extends StatelessWidget implements PreferredSizeWidget {
  
  const ProgramHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {
            // Edit person
          },
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text("Edit Person", style: TextStyle(color: Colors.white)),
          
        ),
        
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
           onPressed: (){},
        ),
      ],
      backgroundColor: Colors.green.shade700,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
