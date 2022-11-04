// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:federated_plugin/federated_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

/// Demonstrates how to use the getBatteryLevel method from federated_plugin to retrieve
/// current battery level of device.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? batteryLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Federated Plugin Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            batteryLevel == null
                ? const SizedBox.shrink()
                : Text(
                    'Battery Level: $batteryLevel',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await getBatteryLevel();
                  setState(() {
                    batteryLevel = result;
                  });
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text(
                        (error as dynamic).message as String,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
