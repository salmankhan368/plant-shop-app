import 'package:demo_proj/features/ai/services/ai_service.dart';
import 'package:firebase_ai/firebase_ai.dart';

class AiRepository {
  final AiService _aiService;
  AiRepository(this._aiService);
  Future<String> askAi(String question, List<Content> history) async {
    return await _aiService.askAi(question, history);
  }
}
