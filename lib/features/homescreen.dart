import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<ModuleItem> modules = [
    ModuleItem("1) Community Register", "1 Community", "13/5/2025", Icons.groups),
    ModuleItem("2) Household Register", "1 Household", "21/3/2025", Icons.home),
    ModuleItem("3) Person Register", "2 Person", "13/5/2025", Icons.person),
    ModuleItem("4-0) IMCI - Integrated Community Case Management", "1 Person", "21/3/2025", Icons.medical_services),
    ModuleItem("4-1) IMCI - Form 1A Supplies Management Table", "0 Data sets", "21/3/2025", Icons.assignment),
    ModuleItem("5) EPI - Expanded Programme on Immunization", "4 Person", "21/3/2025", Icons.vaccines, synced: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
          IconButton(icon: Icon(Icons.view_list), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: modules.length,
        itemBuilder: (context, index) {
          final item = modules[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Icon(item.icon, color: Colors.blue),
                ),
                title: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.subtitle),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.date, style: TextStyle(color: Colors.grey[600])),
                        if (!item.synced)
                          Row(
                            children: [
                              Icon(Icons.sync_problem, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text("Not synced", style: TextStyle(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ModuleItem {
  final String title;
  final String subtitle;
  final String date;
  final IconData icon;
  final bool synced;

  ModuleItem(this.title, this.subtitle, this.date, this.icon, {this.synced = true});
}
