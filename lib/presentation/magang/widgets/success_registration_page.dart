import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_students/core/components/spaces.dart';
import 'package:komdigi_logbooks_students/core/core.dart';
import 'package:komdigi_logbooks_students/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_students/main_page.dart';

class SuccessRegistrationPage extends StatelessWidget {
  const SuccessRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100.0,
                color: Colors.green,
              ),
              const SpaceHeight(
                32.0,
              ),
              SizedBox(
                width: 350.0,
                child: Text(
                  'Terimakasih telah mendaftar PKL di Diskominfosan YK',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SpaceHeight(
                32.0,
              ),
              SizedBox(
                width: 400.0,
                child: Text(
                  'Pendaftaran anda akan diproses dalam beberapa hari kedepan. Respons akan dikirim ke email yang tertera pada pendaftaran Anda.',
                  textAlign: TextAlign.center,
                ),
              ),
              SpaceHeight(16.0),
              Button.filled(onPressed: () {
                context.pushAndRemoveUntil(const MainPage(), (route) => false);
              }, label: 'Lanjutkan'),
            ],
          ),
        ),
      ),
    );
  }
}
