import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_students/core/core.dart';
import 'package:komdigi_logbooks_students/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_students/presentation/progress/pages/progress_dashboard_page.dart';
import 'package:komdigi_logbooks_students/presentation/progress/pages/upload_progress_page.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laman Progress'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SpaceHeight(16.0),
              Button.filled(
                onPressed: () {
                  context.push(const ProgressDashboardPage());
                },
                label: 'Cek Progress',
              ),
              const SpaceHeight(16.0),
              Button.filled(
                onPressed: () {
                  context.push(const UploadProgressPage());
                },
                label: 'Upload Progress',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
