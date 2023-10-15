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
  List<Map<String, dynamic>> todoList = [];

  List<Map<String, dynamic>> finished = [];

  // void _incrementCounter() {
  //   setState(() {});
  // }

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
      floatingActionButton: FullWidthFloatingActionButton(
        todoList: todoList,
        onTodoListChanged: (newList) {
          // Update the parent's todoList with the modified list from the child
          todoList.clear();
          todoList.addAll(newList);
          setState(() {});
        },
      ),
      // add a list view to display all the todo task
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            left: 30,
            right: 30,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // display all finished tasks in a list view
              if (finished.isNotEmpty) const Text("Completed"),

              if (finished.isNotEmpty)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: finished.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // add padding left and right
                      margin: const EdgeInsets.only(top: 10),
                      // set background to white
                      color: Colors.white,
                      child: ListTile(
                        title: Text(finished[index]["title"]),
                        subtitle: Text(finished[index]["description"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  finished.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  todoList.add(finished[index]);
                                  finished.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 20),
              if (todoList.isNotEmpty) const Center(child: Text("Tasks")),
              const SizedBox(height: 10),
              if (todoList.isEmpty) const Center(child: Text("All Done!")),

              if (todoList.isNotEmpty)
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // add padding left and right
                      margin: const EdgeInsets.only(top: 10),
                      // set background to white
                      color: Colors.white,
                      child: ListTile(
                        title: Text(todoList[index]["title"]),
                        subtitle: Text(todoList[index]["description"]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                // remove the task from the list
                                setState(() {
                                  todoList.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            IconButton(
                              onPressed: () {
                                // remove the task from the list
                                setState(() {
                                  // add the task to the finished list
                                  finished.add(todoList[index]);
                                  todoList.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.check),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

class FullWidthFloatingActionButton extends StatefulWidget {
  final List<Map<String, dynamic>> todoList;
  final Function(List<Map<String, dynamic>>) onTodoListChanged;

  const FullWidthFloatingActionButton(
      {super.key, required this.todoList, required this.onTodoListChanged});

  @override
  State<FullWidthFloatingActionButton> createState() =>
      _FullWidthFloatingActionButtonState();
}

class _FullWidthFloatingActionButtonState
    extends State<FullWidthFloatingActionButton> {
  String title = '';
  String description = '';

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
                  color: Colors.white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black26,
                            ),
                            onPressed: () => {
                              // remove the text from the input field when the modal is closed
                              setState(() => {title = "", description = ""}),
                              Navigator.pop(context)
                            },
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
                                  border: OutlineInputBorder(),
                                ),
                                style: const TextStyle(color: Colors.black),
                                onChanged: (title) =>
                                    setState(() => this.title = title),
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
                                  // labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      // borderSide: BorderSide(color: Colors.black),
                                      ),
                                ),
                                // style: const TextStyle(color: Colors.black),
                                onChanged: (description) => setState(
                                    () => this.description = description),
                              ),
                            ),
                            // Button (Full Width)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  List<Map<String, dynamic>> newTodoList =
                                      List.from(widget.todoList);

                                  newTodoList.add({
                                    'title': title,
                                    'description': description
                                  });

                                  // Notify the parent widget about the change
                                  widget.onTodoListChanged(newTodoList);

                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .black, // Set button background color to transparent
                                  shadowColor: Colors
                                      .transparent, // Remove button shadow
                                ),
                                child: const Text(
                                  'Add Task',
                                  style: TextStyle(color: Colors.white),
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
