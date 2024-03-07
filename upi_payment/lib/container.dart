import 'package:flutter/material.dart';

void main() {
  runApp(const container());
}

class container extends StatefulWidget {
  const container({super.key});

  @override
  State<container> createState() => _containerState();
}

class _containerState extends State<container> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      // darkTheme: ThemeData(primarySwatch: Colors.grey),
      // // color: Colors.amberAccent,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Button"),
            backgroundColor: Colors.cyan.shade600,
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
          ),
          body: Center(
            child: Row(
              children: [],
            ),
          )),
    );
  }
}
