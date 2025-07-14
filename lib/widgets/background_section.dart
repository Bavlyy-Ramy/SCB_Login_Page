import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BackgroundSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: Stack(
        children: [
          // Background overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // Background image
          Center(
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
                // Add shadow
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              //  Add overlay
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
