import 'package:material_ui/material_ui.dart';

class LeftDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAddEducationTap;

  const LeftDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAddEducationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MyPortfolio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: onHomeTap,
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Education'),
            onTap: onAddEducationTap,
          ),
        ],
      ),
    );
  }
}
