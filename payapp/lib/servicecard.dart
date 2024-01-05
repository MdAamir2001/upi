import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ServiceCardData {
  final String name;
  final String billedAmount;
  final String dueDate;

  ServiceCardData(this.name, this.billedAmount, this.dueDate);
}

class ServiceCard extends StatelessWidget {
  final ServiceCardData service;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceCard({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.deepPurple : Colors.grey[300],
      elevation: isSelected ? 5.0 : 2.0,
      child: ListTile(
        title: Text(
          service.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.deepPurple),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: ${service.billedAmount}',
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
            Text(
              'Due Date: ${service.dueDate}',
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
