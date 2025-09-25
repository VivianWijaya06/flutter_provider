import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import '../../providers/counter_provider.dart';

// Widget tile untuk setiap counter
// Menampilkan label, value, dan tombol aksi (increment, decrement, edit, delete, change color)
class CounterTile extends StatelessWidget {
  final int index;

  const CounterTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan Consumer agar hanya tile yang berubah yang rebuild
    return Consumer<CounterProvider>(
      builder: (context, model, _) {
        final counter = model.counters[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          elevation: 4,
          color: counter.color.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label dan value counter dengan animasi
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      counter.label,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) =>
                          ScaleTransition(scale: anim, child: child),
                      child: Text(
                        "${counter.value}",
                        key: ValueKey<int>(counter.value),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // Tombol aksi
                Wrap(
                  spacing: 4,
                  children: [
                    // Increment
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => model.increment(index),
                    ),
                    // Decrement
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => model.decrement(index),
                    ),
                    // Color Picker dengan preview realtime
                    IconButton(
                      icon: const Icon(Icons.color_lens, color: Colors.purple),
                      onPressed: () {
                        Color pickerColor = counter.color;
                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                              title: const Text("Pilih Warna"),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: pickerColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      pickerColor = color; // preview realtime
                                    });
                                  },
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text("Save"),
                                  onPressed: () {
                                    model.updateColor(index, pickerColor);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Edit Label
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        final controller = TextEditingController(
                          text: counter.label,
                        );
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Edit Label"),
                            content: TextField(controller: controller),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  controller.dispose();
                                },
                              ),
                              TextButton(
                                child: const Text("Save"),
                                onPressed: () {
                                  model.updateLabel(index, controller.text);
                                  Navigator.pop(context);
                                  controller.dispose();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Delete Counter
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black54),
                      onPressed: () => model.removeCounter(index),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
