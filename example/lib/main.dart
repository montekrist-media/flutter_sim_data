import 'package:flutter/material.dart';
import 'package:device_region/device_region.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example app'),
        ),
        body: FutureBuilder<List<dynamic>?>(
          future: DeviceRegion.getSIMDataInformation(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: Text(
                      'Country code: ${snapshot.data![0].toString().toUpperCase()}\nMobile operator: ${snapshot.data![1]}'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
