import 'package:easystate/easystate.dart';
import 'package:flutter/material.dart';
import 'package:mypuzzle/puzzle.state.dart';
import 'package:mypuzzle/board.dart';

void main() {
  runApp(
    EasyState(
      state: AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppState get state => EasyState.of<AppState>(context);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Puzzle'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Board(
                  crossAxisCount: state.grid,
                  images: state.isNumber ? state.numberedArray : state.images,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  state.shuffle();
                  state.setIsActive(value: true);
                },
                child: const Text('Play'),
              ),
              ElevatedButton(
                onPressed: () {
                  state.setGrid(state.grid == 3 ? 4 : 3);
                  state.setIsActive(value: false);
                  state.changeType(false);
                  setState(() {});
                },
                child: Text('Change to ${state.grid == 3 ? '4x4' : '3x3'}'),
              ),
              ElevatedButton(
                onPressed: () {
                  state.setGrid(state.grid == 3 ? 4 : 3);
                  state.setIsActive(value: false);
                  state.changeType(true);
                  setState(() {});
                },
                child: Text(
                    'Change to Numbered ${state.grid == 3 ? '4x4' : '3x3'}'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
