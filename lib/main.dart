import 'package:devslab/screens/account_screen.dart';
import 'package:devslab/screens/blog_screen.dart';
import 'package:devslab/screens/home_screen.dart';
import 'package:devslab/screens/login_screen.dart';
import 'package:devslab/screens/shop_screen.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,required this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: IndexedStack(
        children: [
          HomeScreen(),
          BlogScreen(),
          ShopScreen(),
          AccountScreen(user: widget.user,),
        ],
        index: index,
      ),
       bottomNavigationBar: BottomNavigationBar(onTap: (index){
         setState(() {
           this.index = index;
         });
       },currentIndex: index,type: BottomNavigationBarType.fixed,items: const [
         BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
         BottomNavigationBarItem(icon: Icon(Icons.chat),label: "Blog"),
         BottomNavigationBarItem(icon: Icon(Icons.business),label: "Shop"),
         BottomNavigationBarItem(icon: Icon(Icons.person),label: "Account"),
       ],

       )
      ,// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
