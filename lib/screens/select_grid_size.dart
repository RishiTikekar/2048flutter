import 'package:borardgame/constants.dart';
import 'package:borardgame/screens/grid_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SelectGridSize extends StatefulWidget {
  const SelectGridSize({super.key});

  @override
  State<SelectGridSize> createState() => _SelectGridSizeState();
}

class _SelectGridSizeState extends State<SelectGridSize> {
  int selectedVal = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          DropdownButton(
            isExpanded: false,
            items: [3, 4, 5, 6, 7, 8, 9].map(
              (val) {
                return DropdownMenuItem(
                  value: val,
                  child: Text(
                    "$val",
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                );
              },
            ).toList(),
            onChanged: (value) {
              if (value != null) {
                selectedVal = value;
                Constants.gridSize = value;
                setState(() {});
              }
            },
            hint: Text(
              selectedVal.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const GridScreen()),
              ),
              child: const Text("NEXT"),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
