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

  testWidgets('Form memvalidasi input dan menampilkan data Education', (
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
}
