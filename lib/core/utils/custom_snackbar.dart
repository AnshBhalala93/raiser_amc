import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:raiser_amc/core/theme/app_fonts.dart';


class AppSnackbar {
  static void show({
    required String title,
    required String message,
    bool isSuccess = true,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
      messageText: _snackContent(title, message, isSuccess),
    );
  }

  static Widget _snackContent(String title, String message, bool isSuccess) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSuccess
              ? [Color(0xFF00C853), Color(0xFF64DD17)]
              : [Color(0xFFD50000), Color(0xFFFF5252)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSuccess ? Icons.check : Icons.close,
              color: Colors.white,
              size: 26,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: AppFonts.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontFamily: AppFonts.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}