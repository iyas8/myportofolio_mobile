import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';

class EducationDetailScreen extends StatelessWidget {
  const EducationDetailScreen({super.key, required this.education});

  final Education education;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Education')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education.school,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(education.degree),
            const SizedBox(height: 8),
            Text('${education.startYear} - ${education.endYear}'),
            const SizedBox(height: 8),
            Text(education.isActive ? 'Masih menempuh pendidikan' : 'Selesai'),
            if (education.description.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(education.description),
            ],
          ],
        ),
      ),
    );
  }
}
