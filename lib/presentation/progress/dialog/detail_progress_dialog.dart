import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_students/core/extensions/extensions.dart';

class DetailProgressDialog extends StatefulWidget {
  final String namaProject;
  final String pertemuanBimbingan;
  final String tanggalBimbingan;
  final String namaProgress;
  const DetailProgressDialog(
      {super.key,
      required this.namaProject,
      required this.pertemuanBimbingan,
      required this.tanggalBimbingan,
      required this.namaProgress,});

  @override
  State<DetailProgressDialog> createState() => _DetailProgressDialogState();
}

class _DetailProgressDialogState extends State<DetailProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Detail Project',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.cancel,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Pertemuan Ke'),
            subtitle: Text(widget.pertemuanBimbingan),
          ),
          ListTile(
            title: const Text('Tanggal Bimbingan'),
            subtitle: Text(widget.tanggalBimbingan),
          ),
          ListTile(
            title: const Text('Project yang Anda Kerjakan'),
            subtitle: Text(widget.namaProject),
          ),
          ListTile(
            title: const Text('Progress Anda'),
            subtitle: Text(widget.namaProgress),
          ),
        ],
      ),
    );
  }
}
