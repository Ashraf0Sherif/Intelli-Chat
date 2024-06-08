import 'package:intellichat/core/gemini/custom_gemini.dart';
import 'package:intellichat/features/chat/repos/chat_repo.dart';

class ChatRepoImplementation implements ChatRepo {
  final CustomGemini customGemini;

  ChatRepoImplementation(this.customGemini);

  @override
  Future<String?> textGeneration({required String prompt}) async {
    try {
      var response = customGemini.textGeneration(prompt: prompt);
      return response;
    } catch (error) {
      print(error);
    }
  }
}
