import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onEducationTap;
  final VoidCallback onAddEducationTap;
  final VoidCallback onAddExperienceTap;

  const LeftDrawer({
    super.key,
    required this.onHomeTap,
    required this.onEducationTap,
    required this.onAddEducationTap,
    required this.onAddExperienceTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

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
            title: const Text('Lihat Education'),
            onTap: onEducationTap,
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Education'),
            onTap: onAddEducationTap,
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: onAddExperienceTap,
          ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pop();
                navigator.push(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                var logoutFailed = false;
                try {
                  await context.read<AuthState>().logout();
                } on Exception {
                  logoutFailed = true;
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      logoutFailed
                          ? 'Sesi diakhiri di perangkat, tetapi server tidak merespons.'
                          : 'Logout berhasil.',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
