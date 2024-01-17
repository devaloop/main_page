Main page: Main menu, sub menus and contents of each menu.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:devaloop_main_page/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
      ),
      home: MainPage(
        appName: 'CareLab',
        appIcon: Image.asset(
          'assets/images/app-logo.png',
          height: 16,
          width: 16,
        ),
        onTapAppIconAndName: () {},
        onTapUserInfo: () {},
        userInfo: 'user@gmail.com',
        mainMenus: const [
          MainMenu(
            text: 'Home',
            icon: Icon(Icons.home),
            content: Text('Content for Home'),
          ),
          MainMenu(
            text: 'Check Up',
            icon: Icon(Icons.app_registration),
            subMenus: [
              SubMenu(
                text: 'Item',
                icon: Icon(Icons.healing),
                content: Text('Content for Clinical Check Up'),
              ),
              SubMenu(
                text: 'Packages',
                icon: Icon(Icons.medical_services),
                content: Text('Content for Packages'),
              ),
            ],
          ),
          MainMenu(
            text: 'Payment',
            icon: Icon(Icons.payment),
            content: Text('Content for Payment'),
          ),
          MainMenu(
            text: 'Scheduling',
            icon: Icon(Icons.schedule),
            content: Text('Content for Scheduling'),
          ),
          MainMenu(
            text: 'Result',
            icon: Icon(Icons.file_copy),
            content: Text('Content for Result'),
          ),
        ],
      ),
    );
  }
}
```