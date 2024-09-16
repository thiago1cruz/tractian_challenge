import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {    
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.navigate('/assets');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Column(
        children: [
          Image.asset('assets/img/logo.png'),
          const SizedBox(height: 20,),
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          const Text('Loading Challenge...'),
        ],
      ),
    );
  }
}