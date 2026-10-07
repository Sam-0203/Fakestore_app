import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String text;

  const CustomLoader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// LOADER
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: const CircularProgressIndicator(
              strokeWidth: 4,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 20),

          /// LOADING TEXT
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
