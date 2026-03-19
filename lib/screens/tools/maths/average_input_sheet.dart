import 'package:flutter/material.dart';

class AverageInputSheet extends StatefulWidget {
  final int count;
  final Function(List<double>) onSubmit;

  const AverageInputSheet({
    super.key,
    required this.count,
    required this.onSubmit,
  });

  @override
  State<AverageInputSheet> createState() =>
      _AverageInputSheetState();
}

class _AverageInputSheetState
    extends State<AverageInputSheet> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.count, (_) => TextEditingController());
  }

  void submit() {
    List<double> vals = [];

    for (final c in controllers) {
      if (c.text.isEmpty) return;
      vals.add(double.parse(c.text));
    }

    widget.onSubmit(vals);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Enter Values",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          ...List.generate(widget.count, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: controllers[i],
                keyboardType:
                const TextInputType.numberWithOptions(
                    decimal: true),
                decoration: InputDecoration(
                  labelText: "Value ${i + 1}",
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: submit,
            child: const Text("Calculate"),
          ),
        ],
      ),
    );
  }
}
