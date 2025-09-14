import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/sns/post_model.dart';
import '../../common/loading_screen.dart';
import '../feed/widget/post_card.dart';
import 'profile_view_model.dart';
import 'widget/profile_header.dart';
import 'widget/profile_edit_dialog.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key, required this.userId});
  
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileViewModelProvider(userId));
    final profileNotifier = ref.read(profileViewModelProvider(userId).notifier);
    final scrollController = useScrollController();

    // スクロール監視でページネーション
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          profileNotifier.loadMorePosts(userId);
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      body: profileState.when(
        data: (state) => RefreshIndicator(
          onRefresh: () => profileNotifier.refreshProfile(userId),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileHeader(
                    profile: state.profile,
                    isFollowing: state.isFollowing,
                    isOwnProfile: state.isOwnProfile,
                    onFollowToggle: () => _handleFollowToggle(context, profileNotifier, userId),
                    onEditProfile: () => _showEditProfileDialog(context, state, profileNotifier),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.article_outlined),
                      const SizedBox(width: 8),
                      Text(
                        '投稿 (${state.posts.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.posts.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'まだ投稿がありません',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == state.posts.length) {
                        return profileNotifier.hasMorePosts
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink();
                      }

                      final post = state.posts[index];
                      return PostCard(
                        post: post,
                        onLike: () => _handleLike(context, post),
                        onComment: () => _handleComment(context, post),
                        onShare: () => _handleShare(context, post),
                      );
                    },
                    childCount: state.posts.length + (profileNotifier.hasMorePosts ? 1 : 0),
                  ),
                ),
            ],
          ),
        ),
        loading: () => const LoadingScreen(),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('プロファイルの読み込みに失敗しました'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => profileNotifier.refreshProfile(userId),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFollowToggle(BuildContext context, ProfileViewModel notifier, String userId) async {
    try {
      await notifier.toggleFollow(userId);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('フォロー処理に失敗しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showEditProfileDialog(
    BuildContext context, 
    ProfileState state, 
    ProfileViewModel notifier,
  ) {
    if (!state.isOwnProfile || state.profile == null) return;

    showDialog<void>(
      context: context,
      builder: (context) => ProfileEditDialog(
        profile: state.profile!,
        onSave: (displayName, bio, isPrivate) async {
          try {
            await notifier.updateProfile(
              displayName: displayName,
              bio: bio,
              isPrivate: isPrivate,
            );
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('プロファイルを更新しました')),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('更新に失敗しました: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
    );
  }

  void _handleLike(BuildContext context, Post post) {
    // TODO(dev): いいね機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('いいね機能は準備中です')),
    );
  }

  void _handleComment(BuildContext context, Post post) {
    // TODO(dev): コメント機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('コメント機能は準備中です')),
    );
  }

  void _handleShare(BuildContext context, Post post) {
    // TODO(dev): 共有機能の実装
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('共有機能は準備中です')),
    );
  }
}