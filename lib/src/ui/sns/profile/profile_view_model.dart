import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/model/sns/follow_model.dart';
import '../../../data/model/sns/post_model.dart';
import '../../../data/repository/sns_repository.dart';
import '../../../utils/logger.dart';

part 'profile_view_model.g.dart';

@riverpod
class ProfileViewModel extends _$ProfileViewModel {
  bool _hasMorePosts = true;
  bool _isLoading = false;

  bool get hasMorePosts => _hasMorePosts;
  bool get isLoading => _isLoading;

  @override
  FutureOr<ProfileState> build(String userId) {
    logger.d('ProfileViewModel.build() called with userId: $userId');
    return loadProfile(userId);
  }

  Future<ProfileState> loadProfile(
    String userId, {
    bool refresh = false,
  }) async {
    if (_isLoading) return state.value ?? const ProfileState();

    try {
      _isLoading = true;

      if (refresh) {
        _hasMorePosts = true;
      }

      final snsRepository = ref.read(snsRepositoryProvider);

      // プロファイル情報、フォロー状態、投稿を並行して取得
      final results = await Future.wait<dynamic>([
        snsRepository.getProfile(userId),
        snsRepository.checkFollowStatus(userId),
        snsRepository.getUserPosts(userId, limit: 20),
      ]);

      final profile = results[0] as UserProfile;
      final followStatus = results[1] as Map<String, dynamic>;
      final posts = results[2] as List<Post>;

      _hasMorePosts = posts.length >= 20;

      logger.d('loadProfile success: profile loaded');

      return ProfileState(
        profile: profile,
        isFollowing: followStatus['isFollowing'] as bool,
        isOwnProfile: followStatus['isOwnProfile'] as bool,
        posts: posts,
      );
    } catch (e, st) {
      logger.e('loadProfile error: $e', error: e, stackTrace: st);
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refreshProfile(String userId) async {
    try {
      final profileState = await loadProfile(userId, refresh: true);
      state = AsyncValue.data(profileState);
    } catch (e, st) {
      logger.e('refreshProfile error: $e', error: e, stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loadMorePosts(String userId) async {
    if (_isLoading || !_hasMorePosts) return;

    final currentState = state.value;
    if (currentState == null) return;

    try {
      _isLoading = true;

      final snsRepository = ref.read(snsRepositoryProvider);
      final lastPostId = currentState.posts.isNotEmpty
          ? currentState.posts.last.id
          : null;

      final newPosts = await snsRepository.getUserPosts(
        userId,
        limit: 20,
        lastPostId: lastPostId,
      );

      _hasMorePosts = newPosts.length >= 20;

      final updatedPosts = [...currentState.posts, ...newPosts];
      final updatedState = currentState.copyWith(posts: updatedPosts);

      state = AsyncValue.data(updatedState);
      logger.d('loadMorePosts success: ${newPosts.length} new posts loaded');
    } catch (e, st) {
      logger.e('loadMorePosts error: $e', error: e, stackTrace: st);
      // エラー時は既存の状態を保持
    } finally {
      _isLoading = false;
    }
  }

  Future<void> toggleFollow(String userId) async {
    final currentState = state.value;
    if (currentState == null || currentState.isOwnProfile) return;

    try {
      final snsRepository = ref.read(snsRepositoryProvider);

      if (currentState.isFollowing) {
        await snsRepository.unfollowUser(userId);
      } else {
        await snsRepository.followUser(userId);
      }

      // フォロー状態を更新
      final updatedProfile = currentState.profile?.copyWith(
        followersCount: currentState.isFollowing
            ? (currentState.profile?.followersCount ?? 1) - 1
            : (currentState.profile?.followersCount ?? 0) + 1,
      );

      final updatedState = currentState.copyWith(
        isFollowing: !currentState.isFollowing,
        profile: updatedProfile,
      );

      state = AsyncValue.data(updatedState);
      logger.d('toggleFollow success: ${!currentState.isFollowing}');
    } catch (e, st) {
      logger.e('toggleFollow error: $e', error: e, stackTrace: st);
      // エラーメッセージを表示するためにrethrow
      rethrow;
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    bool? isPrivate,
  }) async {
    final currentState = state.value;
    if (currentState == null || !currentState.isOwnProfile) return;

    try {
      final snsRepository = ref.read(snsRepositoryProvider);
      final updatedProfile = await snsRepository.updateProfile(
        displayName: displayName,
        bio: bio,
        profileImageUrl: profileImageUrl,
        coverImageUrl: coverImageUrl,
        isPrivate: isPrivate,
      );

      final updatedState = currentState.copyWith(profile: updatedProfile);
      state = AsyncValue.data(updatedState);
      logger.d('updateProfile success');
    } catch (e, st) {
      logger.e('updateProfile error: $e', error: e, stackTrace: st);
      rethrow;
    }
  }
}

class ProfileState {
  const ProfileState({
    this.profile,
    this.isFollowing = false,
    this.isOwnProfile = false,
    this.posts = const [],
  });

  final UserProfile? profile;
  final bool isFollowing;
  final bool isOwnProfile;
  final List<Post> posts;

  ProfileState copyWith({
    UserProfile? profile,
    bool? isFollowing,
    bool? isOwnProfile,
    List<Post>? posts,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isFollowing: isFollowing ?? this.isFollowing,
      isOwnProfile: isOwnProfile ?? this.isOwnProfile,
      posts: posts ?? this.posts,
    );
  }
}
