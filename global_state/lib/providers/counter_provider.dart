import 'package:flutter/material.dart';
import '../../models/counter.dart';

/// Provider untuk mengelola semua counter secara global
class CounterProvider extends ChangeNotifier {
  final List<Counter> _counters = [];

  // Getter untuk list counter
  List<Counter> get counters => _counters;

  // Menambahkan counter baru
  void addCounter() {
    _counters.add(
      Counter(
        label: "Counter ${_counters.length + 1}",
        color: Colors.primaries[_counters.length % Colors.primaries.length],
      ),
    );
    notifyListeners();
  }

  // Menghapus counter
  void removeCounter(int index) {
    _counters.removeAt(index);
    notifyListeners();
  }

  // Increment
  void increment(int index) {
    _counters[index].value++;
    notifyListeners();
  }

  // Decrement, tidak boleh < 0
  void decrement(int index) {
    if (_counters[index].value > 0) {
      _counters[index].value--;
      notifyListeners();
    }
  }

  // Update label
  void updateLabel(int index, String newLabel) {
    _counters[index].label = newLabel;
    notifyListeners();
  }

  // Update color
  void updateColor(int index, Color newColor) {
    _counters[index].color = newColor;
    notifyListeners();
  }

  // Reorder list
  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final counter = _counters.removeAt(oldIndex);
    _counters.insert(newIndex, counter);
    notifyListeners();
  }
}
