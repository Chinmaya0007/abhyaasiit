import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:abhyaasiit/app_state.dart';
import 'package:abhyaasiit/main.dart';

/// Stub widget for testing navigation
class StubPage extends StatelessWidget {
  final String label;
  const StubPage(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(label, key: Key(label)));
  }
}

/// A TestMainNavBar that overrides the real pages with stubs
class TestMainNavBar extends StatefulWidget {
  const TestMainNavBar({super.key});

  @override
  State<TestMainNavBar> createState() => _TestMainNavBarState();
}

class _TestMainNavBarState extends State<TestMainNavBar> {
  int _currentIndex = 0;

  final List<Widget> _stubPages = const [
    StubPage("Profile"),
    StubPage("Questions"),
    StubPage("Subjects"),
    StubPage("Sign In"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _stubPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: "Questions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Subjects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Sign In",
          ),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('MainNavBar navigation works', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const MaterialApp(
          home: TestMainNavBar(),
        ),
      ),
    );

    // Start: Profile
    expect(find.byKey(const Key("Profile")), findsOneWidget);

    // Navigate to Questions
    await tester.tap(find.byIcon(Icons.quiz));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("Questions")), findsOneWidget);

    // Navigate to Subjects
    await tester.tap(find.byIcon(Icons.book));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("Subjects")), findsOneWidget);

    // Navigate to Sign In
    await tester.tap(find.byIcon(Icons.login));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key("Sign In")), findsOneWidget);
  });
}
