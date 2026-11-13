
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final controller = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counter'),
        centerTitle: true,
        backgroundColor: const Color(0xFF173B63),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Counter Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Counter Value',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        '${counter.count}',
                        style: const TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF173B63),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton.filled(
                            onPressed: controller.decrement,
                            icon: const Icon(Icons.remove),
                          ),

                          const SizedBox(width: 20),

                          IconButton.filled(
                            onPressed: controller.increment,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),

                      TextButton(
                        onPressed: controller.resetCounter,
                        child: const Text('Reset Counter'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Timer Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Stopwatch',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        formatTime(counter.elapsedSeconds),
                        style: const TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        children: [
                          ElevatedButton.icon(
                            onPressed: counter.isRunning
                                ? null
                                : controller.startTimer,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Start'),
                          ),

                          ElevatedButton.icon(
                            onPressed: counter.isRunning
                                ? controller.pauseTimer
                                : null,
                            icon: const Icon(Icons.pause),
                            label: const Text('Pause'),
                          ),

                          ElevatedButton.icon(
                            onPressed: controller.resetTimer,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Lifecycle Card
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(
                    Icons.phone_android,
                    color: Colors.blue,
                  ),
                  title: const Text('App Lifecycle'),
                  subtitle: Text(counter.lifecycleState),
                  trailing: Icon(
                    Icons.circle,
                    size: 14,
                    color: counter.lifecycleState == 'Resumed'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
