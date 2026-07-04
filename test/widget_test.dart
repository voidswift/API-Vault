import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api_vault/main.dart';

void main() {
  testWidgets('App boots successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ApiVaultApp()));

    // Verify that we start on the Splash Screen (since initial state is AppState.initial).
    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
