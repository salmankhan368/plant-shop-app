import 'package:demo_proj/features/ai/models/chat_message.dart';
import 'package:demo_proj/features/ai/repository/ai_repository.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';

class AiController extends ChangeNotifier {
  final AiRepository _aiRepository;

  AiController(this._aiRepository);

  bool isLoading = false;
  String? errorMessage;

  List<ChatMessage> messages = [];
  Future<void> askAi(String question) async {
    try {
      // 1. User message UI mein add
      messages.add(ChatMessage(text: question, isUser: true));

      isLoading = true;
      errorMessage = null;

      notifyListeners();

      // 2. Current question ko remove karke previous history banao
      final previousMessages = messages.sublist(0, messages.length - 1);

      final history = previousMessages.map((message) {
        return Content(message.isUser ? 'user' : 'model', [
          TextPart(message.text),
        ]);
      }).toList();

      // 3. Current question separately Gemini ko bhejo
      final response = await _aiRepository.askAi(question, history);

      // 4. AI response UI mein add
      messages.add(ChatMessage(text: response, isUser: false));
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
