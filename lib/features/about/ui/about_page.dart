import 'package:flutter/material.dart';

import 'image_slider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: const Center(
              child: Text(
            'App Overview',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: Colors.teal,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              height: 600,
              width: 300,
              child: ImageSlider(
                imageUrls: [
                  'https://play-lh.googleusercontent.com/S0MNEhSOm8iCZM7XOLm0uEOvC1MGNtg699sC0ZzOfE5wHUdeoFK5xvtsGAPnHhOvRw=w2560-h1440-rw',
                  'https://play-lh.googleusercontent.com/GDIZnv9Cups-45jiTIkJ6eQZ28AOxDsFh6dCi6LjFRF7D55RQUeOcdhKnC3g_lHteQ=w2560-h1440-rw',
                  'https://play-lh.googleusercontent.com/sOd00X1-XgfjKBMkgR8bGv3FaxqPrRJ9fJxU4QXIt4gQfvxSQS6pcb1oP2lj_KYi0f8=w2560-h1440-rw',
                  'https://play-lh.googleusercontent.com/f_y8emobr3M6LVS7V2HLDbyi3t5nJraJ2J_04Kch0ny0qQjepib8SfETBvSID0wsCNM=w2560-h1440-rw'
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
