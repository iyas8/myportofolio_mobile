import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';

Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Tombol Tambah Education membuka form', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Education'));
    await tester.pumpAndSettle();

    expect(find.text('Education Form'), findsOneWidget);
  });

  testWidgets('Drawer dapat membuka form dan kembali ke Home', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.text('Education Form'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('Form Education memvalidasi input dan menampilkan ringkasan', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Nama institusi tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Gelar atau jurusan tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tahun mulai tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Tahun selesai tidak boleh kosong!'), findsOneWidget);

    final fields = find.byType(TextFormField);

    await scrollTo(tester, fields.at(0));
    await tester.enterText(fields.at(0), 'Universitas Indonesia');
    await tester.pump();
    await scrollTo(tester, fields.at(1));
    await tester.enterText(fields.at(1), 'S1 Ilmu Komputer');
    await tester.pump();
    await scrollTo(tester, fields.at(2));
    await tester.enterText(fields.at(2), '2025');
    await tester.pump();
    await scrollTo(tester, fields.at(3));
    await tester.enterText(fields.at(3), '2029');
    await tester.pump();

    final dropdown = find.byType(DropdownButton<bool>);
    await scrollTo(tester, dropdown);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    expect(find.text('Tidak'), findsOneWidget);
    await tester.tap(find.text('Tidak'));
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Data Education'), findsOneWidget);
    expect(find.text('Institusi: Universitas Indonesia'), findsOneWidget);
    expect(find.text('Gelar / Jurusan: S1 Ilmu Komputer'), findsOneWidget);
    expect(find.text('Tahun Mulai: 2025'), findsOneWidget);
    expect(find.text('Tahun Selesai: 2029'), findsOneWidget);
    expect(find.text('Masih menempuh pendidikan: Tidak'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Ya'), findsOneWidget);
    expect(find.text('Universitas Indonesia'), findsNothing);
  });

  testWidgets('Kartu Tambah Experience membuka form baru', (tester) async {
    await tester.pumpWidget(const MyApp());

    await scrollTo(tester, find.text('Tambah Experience'));
    await tester.tap(find.text('Tambah Experience'));
    await tester.pumpAndSettle();

    expect(find.text('Experience Form'), findsOneWidget);
  });

  testWidgets(
    'Drawer membuka Experience dan opsi Home kembali ke halaman utama',
    (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add Experience'));
      await tester.pumpAndSettle();

      expect(find.text('Experience Form'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(
        find.text('Selamat datang di MyPortfolio Mobile!'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Drawer dapat berpindah dari Experience ke Education', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await scrollTo(tester, find.text('Tambah Experience'));
    await tester.tap(find.text('Tambah Experience'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Education'));
    await tester.pumpAndSettle();

    expect(find.text('Education Form'), findsOneWidget);
  });

  testWidgets('Drawer dari Education dapat membuka Experience', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Education'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();

    expect(find.text('Experience Form'), findsOneWidget);
  });

  testWidgets(
    'Experience form menolak isian kosong dan menampilkan ringkasan',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      await scrollTo(tester, find.text('Tambah Experience'));
      await tester.tap(find.text('Tambah Experience'));
      await tester.pumpAndSettle();

      await scrollTo(tester, find.text('Simpan'));
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Judul pengalaman tidak boleh kosong!'), findsOneWidget);
      expect(
        find.text('Deskripsi pengalaman tidak boleh kosong!'),
        findsOneWidget,
      );

      final fields = find.byType(TextFormField);

      await scrollTo(tester, fields.at(0));
      await tester.enterText(fields.at(0), '   ');
      await tester.pump();
      await scrollTo(tester, fields.at(1));
      await tester.enterText(fields.at(1), '   ');
      await tester.pump();
      await scrollTo(tester, find.text('Simpan'));
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Judul pengalaman tidak boleh kosong!'), findsOneWidget);
      expect(
        find.text('Deskripsi pengalaman tidak boleh kosong!'),
        findsOneWidget,
      );

      await scrollTo(tester, fields.at(0));
      await tester.enterText(fields.at(0), 'Asisten Dosen PBP');
      await tester.pump();
      await scrollTo(tester, fields.at(1));
      await tester.enterText(
        fields.at(1),
        'Membantu mahasiswa memahami materi PBP.',
      );
      await tester.pump();

      final categoryDropdown = find.byType(DropdownButton<String>);
      await scrollTo(tester, categoryDropdown);
      await tester.tap(categoryDropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Research').last);
      await tester.pumpAndSettle();

      await scrollTo(tester, find.text('Simpan'));
      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

      expect(find.text('Data Experience'), findsOneWidget);
      expect(find.text('Judul: Asisten Dosen PBP'), findsOneWidget);
      expect(find.text('Kategori: Research'), findsOneWidget);
      expect(
        find.text('Deskripsi: Membantu mahasiswa memahami materi PBP.'),
        findsOneWidget,
      );

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Data Experience'), findsNothing);
      expect(find.text('Asisten Dosen PBP'), findsNothing);
      expect(find.text('Full-Time'), findsOneWidget);
    },
  );
}
