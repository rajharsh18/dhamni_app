import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/chat/chat_modal.dart';
import 'package:dhamni/src/features/chat/chat_reposirory.dart';
import 'package:dhamni/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _chatRepo = Get.put(ChatRepository());
  Future<void> addRequest(ChatModel reqblood) async {
    await _chatRepo.addRequest(reqblood);
  }

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _chatRepo.getUserDetails(email);
    }
    // else {
    //   Get.snackbar("Error", "Login to Continue");
    // }
  }

  Future<List<ChatModel>> getReceiverChat(String email) async {
    return await _chatRepo.receiverChat(email);
  }

  Future<List<ChatModel>> getDonorChat(String email) async {
    return await _chatRepo.donorChat(email);
  }

  Future<List<ChatModel>> getAllChat() async {
    return await _chatRepo.allChat();
  }
}
