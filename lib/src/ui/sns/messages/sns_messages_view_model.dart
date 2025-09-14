import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/message_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'sns_messages_view_model.g.dart';

@riverpod
class SnsMessagesViewModel extends _$SnsMessagesViewModel {
  bool _hasMore = true;
  bool _isLoading = false;
  
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  @override
  FutureOr<List<Conversation>> build() async {
    logger.d('SnsMessagesViewModel.build() called');
    return loadConversations();
  }

  Future<List<Conversation>> loadConversations({bool refresh = false}) async {
    if (_isLoading) return state.valueOrNull ?? [];
    
    try {
      _isLoading = true;
      
      if (refresh) {
        _hasMore = true;
      }
      
      final snsRepository = ref.read(snsRepositoryProvider);
      final conversations = await snsRepository.getConversations(
        limit: 20,
      );
      
      _hasMore = conversations.length >= 20;
      logger.d('loadConversations success: ${conversations.length} conversations loaded');
      
      return conversations;
    } catch (e, st) {
      logger.e('loadConversations error: $e', error: e, stackTrace: st);
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshConversations() async {
    try {
      final conversations = await loadConversations(refresh: true);
      state = AsyncValue.data(conversations);
    } catch (e, st) {
      logger.e('refreshConversations error: $e', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }
}