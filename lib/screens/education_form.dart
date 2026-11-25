import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/screens/education_list_screen.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _school = '';
  String _degree = '';
  String _startYear = '';
  String _endYear = '';
  String _description = '';
  bool _isActive = true;
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final loggedIn = await ensureLoggedIn(context);
      if (!mounted || !loggedIn) return;

      final token = context.read<AuthState>().token;
      if (token == null) return;

      final education = Education(
        school: _school.trim(),
        degree: _degree.trim(),
        startYear: _startYear.trim(),
        endYear: _endYear.trim(),
        description: _description.trim(),
        isActive: _isActive,
      );

      final created = await context.read<ApiClient>().createEducation(
        education,
        token: token,
      );
      if (!mounted) return;

      final activeStatus = created.isActive ? 'Ya' : 'Tidak';
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Education berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Institusi: ${created.school}'),
                  Text('Gelar / Jurusan: ${created.degree}'),
                  Text('Tahun Mulai: ${created.startYear}'),
                  Text('Tahun Selesai: ${created.endYear}'),
                  Text('Deskripsi: ${created.description}'),
                  Text('Masih menempuh pendidikan: $activeStatus'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;
      _formKey.currentState!.reset();
      setState(() {
        _school = '';
        _degree = '';
        _startYear = '';
        _endYear = '';
        _description = '';
        _isActive = true;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        var logoutFailed = false;
        try {
          await context.read<AuthState>().logout();
        } on Exception {
          logoutFailed = true;
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              logoutFailed
                  ? 'Sesi lokal diakhiri. Silakan login kembali.'
                  : 'Sesi login berakhir. Silakan login kembali.',
            ),
          ),
        );
      } else if (error.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Akun ini tidak memiliki izin menambah Education.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan Education (${error.statusCode}).'),
          ),
        );
      }
    } on Exception {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat terhubung ke server Django.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Education Form')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
          Navigator.popUntil(context, (route) => route.isFirst);
        },
        onEducationTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const EducationListScreen(),
            ),
          );
        },
        onAddEducationTap: () {
          Navigator.pop(context);
        },
        onAddExperienceTap: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
          );
        },
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Universitas Indonesia',
                    labelText: 'Nama Sekolah / Universitas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _school = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama institusi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: 'Contoh: S1 Ilmu Komputer',
                    labelText: 'Gelar / Jurusan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _degree = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Gelar atau jurusan tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2025',
                    labelText: 'Tahun Mulai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _startYear = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tahun mulai tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2029',
                    labelText: 'Tahun Selesai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _endYear = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tahun selesai tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Ceritakan sedikit...',
                    labelText: 'Deskripsi Singkat (Opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<bool>(
                  decoration: InputDecoration(
                    labelText: 'Masih Menempuh Pendidikan?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: true,
                  items: const [
                    DropdownMenuItem<bool>(value: true, child: Text('Ya')),
                    DropdownMenuItem<bool>(value: false, child: Text('Tidak')),
                  ],
                  onChanged: (value) {
                    if (value != null) _isActive = value;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
