import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home integration test', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // navigate to tv series tab
    await tester.tap(find.byIcon(Icons.tv).first);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Airing Today'), findsOneWidget);

    // navigate back to movies tab
    await tester.tap(find.byIcon(Icons.movie).first);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Now Playing'), findsOneWidget);

    // open drawer
    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    // drawer items
    expect(find.text('Watchlist Movies'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    // close drawer by tapping outside
    await tester.tapAt(const Offset(300, 300));
    await tester.pumpAndSettle();
  });
}
