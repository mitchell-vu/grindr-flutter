import 'package:fluttr/features/auth/controllers/auth_controller.dart';
import 'package:fluttr/models/user_model.dart';
import 'package:fluttr/models/chat_model.dart';
import 'package:fluttr/features/chat/services/chat_service.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  final ChatService _chatService = ChatService();

  final Rxn<List<({ChatModel chat, UserModel user})>> chatWithUserList =
      Rxn<List<({ChatModel chat, UserModel user})>>();

  @override
  void onInit() {
    super.onInit();
    _loadChats();
  }

  void _loadChats() async {
    final chats = await _chatService.getChatListWithUsers(
      _authController.userModel!.uid,
    );

    chatWithUserList.value = chats;
  }

  Future<void> refreshChatList() async {
    _loadChats();
  }
}
