import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RealTimeChatScreen extends StatefulWidget {
  @override
  _RealTimeChatScreenState createState() => _RealTimeChatScreenState();
}

class _RealTimeChatScreenState extends State<RealTimeChatScreen> {
  final TextEditingController _controller = TextEditingController();

  // Declare the chat collection reference
  final CollectionReference _chatCollection =
      FirebaseFirestore.instance.collection('chats');

  // Declare the predefined answers collection reference
  final CollectionReference _predefinedAnswersCollection =
      FirebaseFirestore.instance.collection('predefined_answers');

  void _sendMessage(String sender, String text, String dpUrl) async {
    if (text.isNotEmpty) {
      try {
        // Add user message to the chat collection
        await _chatCollection.add({
          'text': text,
          'sender': sender,
          'timestamp': FieldValue.serverTimestamp(),
          'dpUrl': dpUrl,
        });

        // Check if there's a predefined response
        final responseSnapshot = await _predefinedAnswersCollection
            .where('question', isEqualTo: text)
            .get();

        if (responseSnapshot.docs.isNotEmpty) {
          final responseText = responseSnapshot.docs.first['response'];
          // Add the predefined response from the support team
          await _chatCollection.add({
            'text': responseText,
            'sender': 'Support',
            'timestamp': FieldValue.serverTimestamp(),
            'dpUrl': 'assets/images/support.jpg', // Replace with actual URL
          });
        } else {
          // Add a default response if no match is found
          await _chatCollection.add({
            'text': "Sorry, I didn't understand that. Can you please rephrase?",
            'sender': 'Support',
            'timestamp': FieldValue.serverTimestamp(),
            'dpUrl': 'assets/images/driver.jpg', // Replace with actual URL
          });
        }
      } catch (e) {
        print("Error sending message: $e");
        // You can show a snackbar or alert dialog here to notify the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Support'),
        backgroundColor: Color(0xFFFFC107), // Set AppBar color
      ),
      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _chatCollection.orderBy('timestamp').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final sender = message['sender'];
                      final text = message['text'];
                      final dpUrl = message['dpUrl'];
                      final isDriver = sender == 'Driver';

                      return Align(
                        alignment: isDriver
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isDriver
                                ? Colors.blueAccent // Color for driver's messages
                                : Colors.greenAccent, // Color for support's messages
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isDriver) ...[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(dpUrl),
                                  radius: 20.0,
                                ),
                                SizedBox(width: 10),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: isDriver
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      sender,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      text,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                              if (!isDriver) ...[
                                SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(dpUrl),
                                  radius: 20.0,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSubmitted: (value) {
                      _sendMessage(
                        'Driver',
                        _controller.text,
                        'https://via.placeholder.com/150',
                      );
                      _controller.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: () {
                    _sendMessage(
                      'Driver',
                      _controller.text,
                      'https://via.placeholder.com/150',
                    );
                    _controller.clear();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
