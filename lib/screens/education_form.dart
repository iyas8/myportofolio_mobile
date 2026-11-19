import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

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

  @override
  Widget build(BuildContext context) {
    final status = _isActive ? 'Ya' : 'Tidak';

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: LeftDrawer(
        onHomeTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        onAddEducationTap: () {
          Navigator.pop(context);
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
                  onChanged: (value) {
                    setState(() {
                      _school = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _degree = value;
                    });
                  },
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
                  decoration: InputDecoration(
                    hintText: 'Contoh: 2025',
                    labelText: 'Tahun Mulai',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _startYear = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _endYear = value;
                    });
                  },
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
                  onChanged: (value) {
                    setState(() {
                      _description = value;
                    });
                  },
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
                    if (value != null) {
                      setState(() {
                        _isActive = value;
                      });
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text('Data Education'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Institusi: ${_school.trim()}'),
                                    Text('Gelar / Jurusan: ${_degree.trim()}'),
                                    Text('Tahun Mulai: ${_startYear.trim()}'),
                                    Text('Tahun Selesai: ${_endYear.trim()}'),
                                    Text('Deskripsi: ${_description.trim()}'),
                                    Text('Masih menempuh pendidikan: $status'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _school = '';
                                      _degree = '';
                                      _startYear = '';
                                      _endYear = '';
                                      _description = '';
                                      _isActive = true;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
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
