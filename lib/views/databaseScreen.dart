import 'package:flutter/material.dart';

class DatabaseTable extends StatefulWidget {
  const DatabaseTable({super.key});

  @override
  State<DatabaseTable> createState() => _DatabaseTableState();
}

class _DatabaseTableState extends State<DatabaseTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Screen'),
      ),
    );
  }
}
