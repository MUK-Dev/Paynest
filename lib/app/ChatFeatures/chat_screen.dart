import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_currency_app/color_changer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static String id = '/chatScreen';

  final currentUser;
  ChatScreen({this.currentUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String newMessage;
  final textFieldController = TextEditingController();

  //check to see if message is from the sender or no
  isMe({String check}) {
    if (_auth.currentUser.email == check) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    String firstName = widget.currentUser.data()['firstName'];
    String lastName = widget.currentUser.data()['lastName'];
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blue,
        elevation: 10,
        backgroundColor: Color(0xff38B6FF),
        title: Text('$firstName $lastName'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/chatbg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: _firestore
              .collection('/users/${widget.currentUser.documentID}/chat')
              .orderBy(
                'timeStamp',
                descending: true,
              )
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshots.hasError) {
              print(snapshots.error);
              return Center(
                child: Text('No Messages Here'),
              );
            } else {
              final List userChat = snapshots.data.documents;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: userChat.length,
                      itemBuilder: (context, index) {
                        final message = userChat[index].data()['message'];
                        final sender = userChat[index].data()['email'];
                        bool senderWho = isMe(check: sender);
                        return Column(
                          crossAxisAlignment: senderWho
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, top: 2, bottom: 2),
                              child: Material(
                                borderRadius: senderWho
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(0),
                                      )
                                    : BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(30),
                                      ),
                                color: senderWho
                                    ? Colors.purple[300]
                                    : Colors.amber,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    message,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                elevation: 10,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textFieldController,
                            onChanged: (value) {
                              newMessage = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter Message here',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xff38B6FF),
                          child: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (newMessage == null) {
                                final snackbar = SnackBar(
                                  content: Text('Please type a message'),
                                  duration: Duration(milliseconds: 4000),
                                );
                                Scaffold.of(context).showSnackBar(snackbar);
                              } else {
                                _firestore
                                    .collection(
                                        '/users/${widget.currentUser.documentID}/chat')
                                    .add({
                                  'message': newMessage,
                                  'email': _auth.currentUser.email,
                                  'timeStamp': FieldValue.serverTimestamp(),
                                });
                                textFieldController.clear();
                                newMessage = null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
