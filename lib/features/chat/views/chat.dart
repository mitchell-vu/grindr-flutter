import 'package:flutter/material.dart';
import 'package:fluttr/features/auth/models/user_model.dart';
import 'package:fluttr/features/chat/models/message_model.dart';
import 'package:fluttr/features/chat/services/chat_service.dart';
import 'package:fluttr/features/chat/views/widgets/message_bubble.dart';
import 'package:fluttr/shared/services/auth_service.dart';
import 'package:fluttr/shared/services/firestore_service.dart';
import 'package:fluttr/shared/utils/page_transaction.dart';
import 'package:fluttr/features/profile/views/profile.dart';
import 'package:fluttr/shared/widgets/avatar.dart';
import 'package:fluttr/theme/color.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.otherUserId});

  final String otherUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  UserModel? otherUser;
  late final String chatId;
  late Stream<List<MessageModel>> messagesStream;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadOtherUser();

    chatId = generateChatId(currentUser.value!.uid, widget.otherUserId);
    messagesStream = ChatService().getChatStream(chatId);
    scrollToBottom();
  }

  Future<void> _loadOtherUser() async {
    final user = await FirestoreService().getUser(widget.otherUserId);
    setState(() {
      otherUser = user;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void handleSendMessage() {
    final message = _messageController.text;

    if (message.isNotEmpty) {
      final newMessage = MessageModel(
        senderId: currentUser.value!.uid,
        content: message,
        type: MessageType.text,
        isRead: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      ChatService().sendMessage(
        currentUser.value!.uid,
        widget.otherUserId,
        newMessage,
      );

      _messageController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    //? TODO: Tìm hiểu SchedulerBinding với WidgetsBinding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
              context,
              slideToTopPageTransition(ProfilePage(uid: widget.otherUserId)),
            );
          },
          child: Row(
            spacing: 12,
            children: [
              Avatar(url: otherUser?.photoUrl, size: 40),
              Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      Icon(Icons.circle, size: 12, color: AppColors.success),
                      Text(
                        otherUser?.displayName ?? '',
                        style: TextStyle(fontSize: 14, fontWeight: .w700),
                      ),
                    ],
                  ),
                  Text('2km away', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const .symmetric(vertical: 16.0),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: messagesStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final messages = snapshot.data!;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final chatMessage = messages[index];
                        final isNextMessageSameUser =
                            index < messages.length - 1 &&
                            messages[index + 1].senderId ==
                                chatMessage.senderId;

                        return MessageBubble(
                          message: chatMessage,
                          showTimestamp: !isNextMessageSameUser,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const .only(
                  left: 12.0,
                  right: 12.0,
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: Column(
                  spacing: 8,
                  children: [
                    Container(
                      padding: const .only(
                        left: 20,
                        right: 4,
                        top: 4,
                        bottom: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Say something...',
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: AppColors.primary,
                            onPressed: handleSendMessage,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.photo_camera),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.gif_box),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.navigation_sharp),
                          color: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.emoji_emotions),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
