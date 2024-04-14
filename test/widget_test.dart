import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:firebase_database/firebase_database.dart';

class StreamView extends StatefulWidget {
  const StreamView({Key? key}) : super(key: key);

  @override
  _StreamViewState createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> {
  late Uint8List _imageFile;
  final controller = ScreenshotController();
  late WebSocketChannel? channel;
  late String IP;

  @override
  void initState() {
    super.initState();
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    final refdata = FirebaseDatabase.instance.ref();
    refdata.child('IP/').onValue.listen((event) {
      setState(() {
        IP = event.snapshot.value.toString();
        channel = IOWebSocketChannel.connect('ws://$IP:81');
        print(IP);
      });
    });
  }

  void reconnect() {
    setState(() {
      if (IP.isNotEmpty) {
        channel = IOWebSocketChannel.connect('ws://$IP:81');
      } else {
        print('IP is not available');
      }
    });
  }

  Future<void> _saveImage(Uint8List imageBytes) async {
    try {
      final result = await ImageGallerySaver.saveImage(imageBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image saved to: $result')),
      );
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream View'),
      ),
      body: Screenshot(
        controller: controller,
        child: StreamBuilder(
          stream: channel?.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Image.memory(
                snapshot.data,
                gaplessPlayback: true,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.capture().then((image) async {
            if (image != null) {
              await _saveImage(image);
            } else {
              print('Failed to capture image');
            }
          }).catchError((onError) {
            print('Error capturing image: $onError');
          });
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
