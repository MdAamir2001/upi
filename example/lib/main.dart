import 'package:flutter/material.dart';
void main(){
  runApp(
      MaterialApp(
        home:abc(),
      ));

}

class abc extends StatelessWidget {
  const abc({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        width: 5,
      ),
      borderRadius: BorderRadius.circular(5),
    );
    return Scaffold(
    body: Center(
         child:TextField(
           decoration: InputDecoration(
               hintText: 'Name',
             prefixIcon: const Icon(Icons.access_alarms_outlined),
             focusedBorder:border,
             enabledBorder: border,
           ),
  ),
),
    );
  }
}

