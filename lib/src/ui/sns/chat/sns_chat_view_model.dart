import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/message_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'sns_chat_view_model.g.dart';

@riverpod
class SnsChatViewModel extends _$SnsChatViewModel {
  bool _hasMore = true;
  bool _isLoading = false;
  String? _conversationId;

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;
  @override
  String get conversationId => _conversationId ?? '';

  @override
  FutureOr<List<DirectMessage>> build(String conversationId) async {
    logger.d(
      'SnsChatViewModel.build() called with conversationId: $conversationId',
    );
    _conversationId = conversationId;
    return loadMessages();
  }

  Future<List<DirectMessage>> loadMessages({bool refresh = false}) async {
    if (_isLoading || _conversationId == null) return state.valueOrNull ?? [];

    try {
      _isLoading = true;

      if (refresh) {
        _hasMore = true;
      }

      final snsRepository = ref.read(snsRepositoryProvider);
      final messages = await snsRepository.getMessages(
        conversationId: _conversationId!,
        limit: 50,
      );

      _hasMore = messages.length >= 50;
      logger.d('loadMessages success: ${messages.length} messages loaded');

      // メッセージを時系列順（古い順）に並び替え
      messages.sort((a, b) {
        final aTime = a.createdAt ?? DateTime.now();
        final bTime = b.createdAt ?? DateTime.now();
        return aTime.compareTo(bTime);
      });

      return messages;
    } catch (e, st) {
      logger.e('loadMessages error: $e', error: e, stackTrace: st);
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshMessages() async {
    try {
      final messages = await loadMessages(refresh: true);
      state = AsyncValue.data(messages);
    } catch (e, st) {
      logger.e('refreshMessages error: $e', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String content,
    MessageType type = MessageType.text,
    List<String>? attachmentUrls,
  }) async {
    if (content.trim().isEmpty) return;

    try {
      final snsRepository = ref.read(snsRepositoryProvider);
      final newMessage = await snsRepository.sendMessage(
        receiverId: receiverId,
        content: content.trim(),
        type: type,
        attachmentUrls: attachmentUrls,
      );

      // 新しいメッセージを既存のリストに追加
      final currentMessages = state.valueOrNull ?? [];
      final updatedMessages = [...currentMessages, newMessage];
      state = AsyncValue.data(updatedMessages);

      logger.d('sendMessage success: ${newMessage.id}');
    } catch (e, st) {
      logger.e('sendMessage error: $e', error: e, stackTrace: st);
      // エラー時は元の状態を保持し、エラーメッセージを表示
      rethrow;
    }
  }
}
