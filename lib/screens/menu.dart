import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/education_list_screen.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = '2506593891';
  final String nama = 'Muhammad Ilhami Yasya';
  final String kelas = 'PBP D';

  final List<ItemHomepage> items = const [
    ItemHomepage('Lihat Education', Icons.school, Colors.blue),
    ItemHomepage('Tambah Education', Icons.add_circle, Colors.green),
    ItemHomepage('Tambah Experience', Icons.work, Colors.purple),
    ItemHomepage('Logout', Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
        },
        onEducationTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EducationListScreen(),
            ),
          );
        },
        onAddEducationTap: () async {
          Navigator.pop(context);
          final loggedIn = await ensureLoggedIn(context);
          if (!context.mounted || !loggedIn) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EducationFormPage()),
          );
        },
        onAddExperienceTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Selamat datang di MyPortfolio Mobile!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              GridView.count(
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.zero,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13.0),
            ),
          ],
        ),
      ),
    );
  }
}
