import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Home menampilkan identitas pemilik portfolio', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.text('2506593891'), findsOneWidget);
    expect(find.text('Muhammad Ilhami Yasya'), findsOneWidget);
    expect(find.text('PBP D'), findsOneWidget);
  });

  testWidgets('Tambah Education meminta login terlebih dahulu', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    await tester.tap(find.text('Tambah Education'));
    await tester.pumpAndSettle();

    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Education Form'), findsNothing);
  });

  testWidgets('Login memvalidasi username dan password kosong', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Username tidak boleh kosong!'), findsOneWidget);
    expect(find.text('Password tidak boleh kosong!'), findsOneWidget);
  });

  testWidgets('Tambah Experience tetap membuka form lokal', (tester) async {
    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    final card = find.text('Tambah Experience');
    await tester.ensureVisible(card);
    await tester.pumpAndSettle();
    await tester.tap(card);
    await tester.pumpAndSettle();

    expect(find.text('Experience Form'), findsOneWidget);
  });
}
