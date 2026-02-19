import 'package:flutter/material.dart';

class AqiCard extends StatelessWidget {
  final int value;
  final int maxAqi;

  const AqiCard({super.key, required this.value, required this.maxAqi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF242323),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.air, color: Colors.white70, size: 18),
              SizedBox(width: 6),
              Text("Air quality", style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Satisfactory air quality",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 14),

          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = constraints.maxWidth;

              // Clamp value to avoid overflow
              final clampedValue = value.clamp(0, maxAqi);

              final position = (clampedValue / maxAqi) * barWidth;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Colored bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        _segment(Colors.green),
                        _segment(Colors.lightGreen),
                        _segment(Colors.yellow),
                        _segment(Colors.orange),
                        _segment(Colors.red),
                        _segment(Colors.purple),
                      ],
                    ),
                  ),

                  // Indicator dot
                  Positioned(
                    left: position-6, // center the dot
                    top: -3,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _segment(Color color) {
    return Expanded(
      child: Container(
        color: color,
        height: 6,
      ),
    );
  }
}
