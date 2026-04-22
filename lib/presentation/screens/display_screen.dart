import 'package:digital_signage_system/presentation/widgets/media_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('contents').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No Content"));
          }

          final data = docs[currentIndex].data() as Map<String, dynamic>;

          Future.delayed(Duration(seconds: data['duration']), () {
            if (mounted) {
              setState(() {
                currentIndex = (currentIndex + 1) % docs.length;
              });
            }
          });

          return MediaWidget(url: data['url'], type: data['type']);
        },
      ),
    );
  }
}
