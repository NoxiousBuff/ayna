import 'package:ayna/src/models/message.dart';
import 'package:ayna/src/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  WebSocketChannel? channel;
  final _chatTech = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.org'));
    channel!.stream.listen((message) {
      if (!message.toString().contains('Request served by')) {
        Hive.box<Message>('messages').add(
          Message(text: message, timestamp: DateTime.now(), id: 0),
        );
      }
      print(message.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<Message>('messages').listenable(),
                  builder: ((context, box, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final n = box.length - index-1;
                        Message message = box.getAt(n) ??
                            Message(
                              text: 'No messages',
                              timestamp: DateTime.now(),
                              id: 100,
                            );
                        return Row(
                          mainAxisAlignment: message.id == 0
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: message.id == 0
                                      ? Colors.grey.shade300
                                      : Colors.blue.shade700,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                message.text,
                                style: TextStyle(
                                    color: message.id == 0
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }),
                ),
              ),
              verticalSpaceRegular,
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Type a message',
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onEditingComplete: () {
                  _sendMessage();
                },
                controller: _chatTech,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _sendMessage,
          tooltip: 'Send message',
          child: const Icon(Icons.send),
        ),
      );
    });
  }

  void _sendMessage() {
    if (_chatTech.text.isNotEmpty) {
      channel!.sink.add(_chatTech.text);
      Hive.box<Message>('messages').add(
        Message(text: _chatTech.text, timestamp: DateTime.now(), id: 1),
      );
      _chatTech.clear();
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    channel!.sink.close();
    _chatTech.dispose();
    super.dispose();
  }
}
