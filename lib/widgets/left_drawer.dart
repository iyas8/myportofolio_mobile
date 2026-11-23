import 'package:material_ui/material_ui.dart';

class LeftDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onAddEducationTap;
  final VoidCallback onAddExperienceTap;

  const LeftDrawer({
    super.key,
    required this.onHomeTap,
    required this.onAddEducationTap,
    required this.onAddExperienceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Align(
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
            leading: const Icon(Icons.school_outlined),
            title: const Text('Add Education'),
            onTap: onAddEducationTap,
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: onAddExperienceTap,
          ),
        ],
      ),
    );
  }
}
