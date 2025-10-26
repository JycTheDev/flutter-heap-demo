import 'package:flutter/material.dart';
import 'heap.dart';

void main() => runApp(const HeapApp());

class HeapApp extends StatefulWidget {
  const HeapApp({super.key});

  @override
  State<HeapApp> createState() => _HeapAppState();
}

class _HeapAppState extends State<HeapApp> {
  late Heap heap;
  bool isMinHeap = true;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    heap = Heap(isMinHeap: true);
  }

  void _toggleHeapMode(bool value) {
    setState(() {
      isMinHeap = value;
      heap = Heap(isMinHeap: isMinHeap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Heap Visualizer",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Heap Visualizer"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Toggle switch for heap type
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Min Heap"),
                  Switch(
                    value: !isMinHeap,
                    onChanged: (value) => _toggleHeapMode(!value),
                    activeColor: Colors.deepOrange,
                  ),
                  const Text("Max Heap"),
                ],
              ),

              const SizedBox(height: 16),

              // Input field
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter a number",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      final val = int.tryParse(controller.text);
                      if (val != null) {
                        setState(() => heap.insert(val));
                        controller.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Insert"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => heap.extract());
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    label: Text(isMinHeap ? "Extract Min" : "Extract Max"),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Heap visualization
              Expanded(
                child: heap.values.isEmpty
                    ? const Center(
                        child: Text(
                          "Heap is empty",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: heap.values.length,
                        itemBuilder: (context, index) {
                          final value = heap.values[index];
                          return Card(
                            color: Colors.blue.shade50,
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Center(
                                child: Text(
                                  value.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
