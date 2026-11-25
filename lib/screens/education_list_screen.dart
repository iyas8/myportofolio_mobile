import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/screens/education_detail_screen.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class EducationListScreen extends StatefulWidget {
  const EducationListScreen({super.key});

  @override
  State<EducationListScreen> createState() => _EducationListScreenState();
}

class _EducationListScreenState extends State<EducationListScreen> {
  late Future<List<Education>> _educationsFuture;

  @override
  void initState() {
    super.initState();
    _educationsFuture = context.read<ApiClient>().getEducations();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getEducations();
    setState(() {
      _educationsFuture = future;
    });

    try {
      await future;
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui Education.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onEducationTap: () {
          Navigator.pop(context);
        },
        onAddEducationTap: () async {
          Navigator.pop(context);
          final loggedIn = await ensureLoggedIn(context);
          if (!context.mounted || !loggedIn) return;
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EducationFormPage()),
          );
          if (mounted) await _reload();
        },
        onAddExperienceTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
          );
        },
      ),
      body: FutureBuilder<List<Education>>(
        future: _educationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Gagal memuat riwayat pendidikan. Periksa koneksi server.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _reload,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final educations = snapshot.data ?? const <Education>[];

          if (educations.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 400,
                    child: Center(child: Text('Belum ada riwayat pendidikan.')),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];
                return Card(
                  child: ListTile(
                    title: Text(education.school),
                    subtitle: Text(
                      '${education.degree} • ${education.startYear} - ${education.endYear}',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EducationDetailScreen(education: education),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
