
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/counter_controller.dart';

final counterProvider =
    NotifierProvider<CounterController, CounterState>(
  CounterController.new,
);
