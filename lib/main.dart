import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart'; 
import 'pages/profile_page.dart';
import 'pages/questions_page.dart';
import 'pages/select_subject_page.dart';
import 'pages/signin_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavBar(),
    );
  }
}

class MainNavBar extends StatefulWidget {
  const MainNavBar({super.key});

  @override
  State<MainNavBar> createState() => _MainNavBarState();
}

class _MainNavBarState extends State<MainNavBar> {
  int _currentIndex = 3;

  late final List<Widget> _pages = [
    const ProfilePage(),
    // QuestionScreen will later read topicId from AppState instead of hardcoded
    Consumer<AppState>(
      builder: (context, state, _) {
        return QuestionScreen(
          topicId: state.selectedTopicId ?? "t1", // fallback
        );
      },
    ),
    const SelectSubjectPage(),
    const SignInPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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
