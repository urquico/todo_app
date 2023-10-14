import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Today'),
      // remove debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variable to store all the todo task from the local storage
  List<String> todoList = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // set background color to black
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          // bold text with black color
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: const FullWidthFloatingActionButton(),
    );
  }
}

class FullWidthFloatingActionButton extends StatelessWidget {
  const FullWidthFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 30.0), // Adjust the left padding as needed
      child: SizedBox(
        width: MediaQuery.of(context)
            .size
            .width, // Set the width to the screen width
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              clipBehavior: Clip.none,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Text Input (Single Line)
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                maxLength: 30,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            // Text Area (Multiline Text Input)
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: TextFormField(
                                maxLines: 8,
                                maxLength: 100,
                                decoration: const InputDecoration(
                                  labelText: 'Enter task description',
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            // Button (Full Width)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your button action here
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
