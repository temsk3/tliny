# Multi-Agent Workflow Examples

## 実際の協調ワークフローの詳細例

### 例1: SNS機能の新規実装

#### 初期要件
```yaml
title: "[MULTI-AGENT] SNS機能（投稿・コメント・フォロー）の実装"
complexity: High
estimated_duration: 2 weeks
stakeholders: ["product-team", "design-team"]

requirements:
  - ユーザー投稿機能
  - コメント・いいね機能
  - フォロー・フォロワー機能
  - リアルタイム通知
  - プライバシー設定
```

#### Conductor Agent による分析と分解
```yaml
task_analysis:
  technical_domains:
    - firebase_functions: "投稿・コメント・フォローのAPI"
    - firestore_design: "SNSデータモデル設計"
    - riverpod_state: "SNS状態管理とリアルタイム更新"
    - flutter_ui: "投稿フォーム・タイムライン・プロフィール画面"
    - testing: "SNS機能の統合テスト"

  dependency_graph:
    phase_1: ["firestore_design", "firebase_functions"] # 並行
    phase_2: ["riverpod_state"] # phase_1 依存
    phase_3: ["flutter_ui"] # phase_2 依存
    phase_4: ["testing"] # 全 phase 依存

  sub_issues:
    - title: "[FUNCTIONS] SNS Cloud Functions実装"
      assignee: "firebase-functions-developer"
      deliverables:
        - "v2_sns_post_create"
        - "v2_sns_comment_create"
        - "v2_sns_follow_manage"
        - "v2_sns_notification_send"

    - title: "[RIVERPOD] SNS状態管理Provider実装"
      assignee: "riverpod-state-manager"
      dependencies: ["FUNCTIONS"]
      deliverables:
        - "PostNotifier"
        - "CommentNotifier"
        - "FollowNotifier"
        - "NotificationNotifier"

    - title: "[UI] SNS画面とコンポーネント実装"
      assignee: "flutter-ui-builder"
      dependencies: ["RIVERPOD"]
      deliverables:
        - "PostComposePage"
        - "TimelinePage"
        - "ProfilePage"
        - "NotificationPage"

    - title: "[TEST] SNS機能統合テスト"
      assignee: "test-automation-engineer"
      dependencies: ["UI", "FUNCTIONS"]
      deliverables:
        - "投稿フロー統合テスト"
        - "コメント機能テスト"
        - "フォロー機能テスト"
```

#### Phase 1: バックエンド基盤実装

**Firebase Functions Developer の実装**:
```typescript
// functions/src/v2/sns/post.ts
export const v2_sns_post_create = onCall({
  region: 'asia-northeast1',
}, async (request) => {
  const { content, imageUrls, privacy } = request.data;
  const userId = request.auth?.uid;

  if (!userId) {
    throw new HttpsError('unauthenticated', 'User not authenticated');
  }

  const postData = {
    id: db.collection('posts').doc().id,
    userId,
    content,
    imageUrls: imageUrls || [],
    privacy: privacy || 'public',
    createdAt: FieldValue.serverTimestamp(),
    likesCount: 0,
    commentsCount: 0,
  };

  await db.collection('posts').doc(postData.id).set(postData);

  // Notification to followers
  await notifyFollowers(userId, postData);

  return { postId: postData.id };
});

// functions/src/v2/sns/follow.ts
export const v2_sns_follow_manage = onCall(async (request) => {
  const { targetUserId, action } = request.data; // action: 'follow' | 'unfollow'
  const currentUserId = request.auth?.uid;

  if (!currentUserId) {
    throw new HttpsError('unauthenticated', 'User not authenticated');
  }

  const batch = db.batch();

  if (action === 'follow') {
    // Add to following list
    batch.set(db.collection('users').doc(currentUserId).collection('following').doc(targetUserId), {
      followedAt: FieldValue.serverTimestamp()
    });

    // Add to followers list
    batch.set(db.collection('users').doc(targetUserId).collection('followers').doc(currentUserId), {
      followedAt: FieldValue.serverTimestamp()
    });

    // Send notification
    await sendNotification(targetUserId, {
      type: 'follow',
      fromUserId: currentUserId,
      createdAt: FieldValue.serverTimestamp()
    });
  } else {
    // Remove from following/followers
    batch.delete(db.collection('users').doc(currentUserId).collection('following').doc(targetUserId));
    batch.delete(db.collection('users').doc(targetUserId).collection('followers').doc(currentUserId));
  }

  await batch.commit();
  return { success: true };
});
```

**エージェント間の協調メッセージ**:
```json
{
  "from": "firebase-functions-developer",
  "to": "riverpod-state-manager",
  "message_type": "dependency_ready",
  "completed_deliverables": {
    "post_functions": {
      "v2_sns_post_create": {
        "input_schema": "PostCreateData",
        "output_schema": "PostCreateResult",
        "error_types": ["unauthenticated", "invalid-argument"]
      },
      "v2_sns_follow_manage": {
        "input_schema": "FollowActionData",
        "output_schema": "FollowResult"
      }
    },
    "data_models": "functions/src/v2/sns/types.ts",
    "api_documentation": "docs/sns-api-spec.md"
  },
  "integration_notes": [
    "投稿作成時は自動的にフォロワーに通知",
    "プライバシー設定に応じた表示制御が必要",
    "リアルタイム更新はFirestore listenerを推奨"
  ]
}
```

#### Phase 2: 状態管理実装

**Riverpod State Manager の実装**:
```dart
// lib/src/ui/sns/providers/post_provider.dart
@riverpod
class PostNotifier extends _$PostNotifier {
  @override
  FutureOr<PostState> build() async {
    // Initialize with user's timeline
    final posts = await _loadTimelinePosts();
    return PostState(posts: posts);
  }

  Future<void> createPost({
    required String content,
    List<String>? imageUrls,
    PostPrivacy privacy = PostPrivacy.public,
  }) async {
    state = AsyncValue.data(state.value!.copyWith(isCreating: true));

    try {
      final functions = ref.read(cloudFunctionsProvider);
      final result = await functions.httpsCallable('v2_sns_post_create').call({
        'content': content,
        'imageUrls': imageUrls,
        'privacy': privacy.name,
      });

      // Refresh timeline to show new post
      await refreshTimeline();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshTimeline() async {
    try {
      final posts = await _loadTimelinePosts();
      state = AsyncValue.data(PostState(posts: posts));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // リアルタイム更新の設定
  void startRealtimeUpdates() {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return;

    // フォローしているユーザーの投稿をリアルタイム監視
    ref.listen(realtimePostStreamProvider, (previous, next) {
      next.when(
        data: (newPosts) {
          final currentState = state.value;
          if (currentState != null) {
            state = AsyncValue.data(currentState.copyWith(
              posts: _mergePostsWithTimeline(currentState.posts, newPosts)
            ));
          }
        },
        error: (error, stackTrace) {
          // エラーハンドリング
        },
        loading: () {},
      );
    });
  }
}

// リアルタイムストリーム
@riverpod
Stream<List<Post>> realtimePostStream(RealtimePostStreamRef ref) {
  final userId = ref.read(authRepositoryProvider).currentUser?.uid;
  if (userId == null) return Stream.empty();

  return FirebaseFirestore.instance
      .collection('posts')
      .where('privacy', isEqualTo: 'public')
      .orderBy('createdAt', descending: true)
      .limit(20)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Post.fromFirestore(doc))
          .toList());
}

// フォロー状態管理
@riverpod
class FollowNotifier extends _$FollowNotifier {
  @override
  FutureOr<FollowState> build() async {
    final userId = ref.read(authRepositoryProvider).currentUser?.uid;
    if (userId == null) return FollowState.initial();

    final following = await _loadFollowing(userId);
    final followers = await _loadFollowers(userId);

    return FollowState(
      following: following,
      followers: followers,
    );
  }

  Future<void> toggleFollow(String targetUserId) async {
    final currentState = state.value!;
    final isCurrentlyFollowing = currentState.following.contains(targetUserId);

    state = AsyncValue.data(currentState.copyWith(isProcessing: true));

    try {
      final functions = ref.read(cloudFunctionsProvider);
      await functions.httpsCallable('v2_sns_follow_manage').call({
        'targetUserId': targetUserId,
        'action': isCurrentlyFollowing ? 'unfollow' : 'follow',
      });

      // Update local state
      final updatedFollowing = Set<String>.from(currentState.following);
      if (isCurrentlyFollowing) {
        updatedFollowing.remove(targetUserId);
      } else {
        updatedFollowing.add(targetUserId);
      }

      state = AsyncValue.data(currentState.copyWith(
        following: updatedFollowing,
        isProcessing: false,
      ));

      // Invalidate related providers
      ref.invalidate(userProfileProvider(targetUserId));
      ref.invalidate(postNotifierProvider);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
```

**エージェント間協調メッセージ**:
```json
{
  "from": "riverpod-state-manager",
  "to": "flutter-ui-builder",
  "message_type": "dependency_ready",
  "completed_deliverables": {
    "providers": {
      "PostNotifier": {
        "states": ["loading", "data", "error"],
        "actions": ["createPost", "refreshTimeline", "toggleLike"],
        "realtime": true
      },
      "FollowNotifier": {
        "states": ["following", "followers", "isProcessing"],
        "actions": ["toggleFollow", "loadFollowSuggestions"]
      }
    },
    "state_models": "lib/src/data/model/sns/",
    "usage_patterns": "docs/sns-state-usage.md"
  },
  "ui_integration_notes": [
    "PostNotifier.startRealtimeUpdates()をタイムライン画面で呼び出し",
    "FollowNotifier.toggleFollow()はボタン押下時に非同期実行",
    "エラー状態はSnackBarで表示を推奨",
    "ローディング状態は適切なインジケーター表示"
  ]
}
```

#### Phase 3: UI実装

**Flutter UI Builder の実装**:
```dart
// lib/src/ui/sns/timeline_page.dart
class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  @override
  void initState() {
    super.initState();
    // リアルタイム更新を開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postNotifierProvider.notifier).startRealtimeUpdates();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('タイムライン'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/sns/post/create'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(postNotifierProvider.notifier).refreshTimeline(),
        child: postState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => ErrorWidget(
            error: error,
            onRetry: () => ref.invalidate(postNotifierProvider),
          ),
          data: (state) => _buildTimeline(state),
        ),
      ),
    );
  }

  Widget _buildTimeline(PostState state) {
    if (state.posts.isEmpty) {
      return const EmptyStateWidget(
        message: 'まだ投稿がありません',
        action: 'フォローして投稿を見つけましょう',
      );
    }

    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        final post = state.posts[index];
        return PostCard(
          post: post,
          onLike: () => _handleLike(post),
          onComment: () => _navigateToComments(post),
          onShare: () => _handleShare(post),
        );
      },
    );
  }

  void _handleLike(Post post) {
    ref.read(postNotifierProvider.notifier).toggleLike(post.id);
  }

  void _navigateToComments(Post post) {
    context.push('/sns/post/${post.id}/comments');
  }

  void _handleShare(Post post) {
    // Share functionality
  }
}

// lib/src/ui/sns/widgets/post_card.dart
class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;

  const PostCard({
    super.key,
    required this.post,
    this.onLike,
    this.onComment,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.author.avatarUrl),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.displayName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _formatDate(post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post content
            Text(
              post.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            if (post.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 12),
              PostImageGallery(imageUrls: post.imageUrls),
            ],

            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                  label: '${post.likesCount}',
                  color: post.isLiked ? Colors.red : null,
                  onTap: onLike,
                ),
                _ActionButton(
                  icon: Icons.comment,
                  label: '${post.commentsCount}',
                  onTap: onComment,
                ),
                _ActionButton(
                  icon: Icons.share,
                  label: 'シェア',
                  onTap: onShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}日前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}時間前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分前';
    } else {
      return 'たった今';
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/src/ui/sns/post_create_page.dart
class PostCreatePage extends ConsumerStatefulWidget {
  const PostCreatePage({super.key});

  @override
  ConsumerState<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends ConsumerState<PostCreatePage> {
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PostPrivacy _selectedPrivacy = PostPrivacy.public;
  List<String> _selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final postState = ref.watch(postNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('投稿作成'),
        actions: [
          TextButton(
            onPressed: postState.isLoading ? null : _handlePost,
            child: postState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('投稿'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Content input
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: '今何を考えていますか？',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return '投稿内容を入力してください';
                  }
                  if (value!.length > 500) {
                    return '投稿は500文字以内で入力してください';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Privacy selection
              DropdownButtonFormField<PostPrivacy>(
                value: _selectedPrivacy,
                decoration: const InputDecoration(
                  labelText: '公開設定',
                  border: OutlineInputBorder(),
                ),
                items: PostPrivacy.values.map((privacy) {
                  return DropdownMenuItem(
                    value: privacy,
                    child: Text(privacy.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPrivacy = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // Image selection
              ImageSelectionWidget(
                selectedImages: _selectedImages,
                onImagesChanged: (images) {
                  setState(() {
                    _selectedImages = images;
                  });
                },
                maxImages: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePost() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await ref.read(postNotifierProvider.notifier).createPost(
        content: _contentController.text.trim(),
        imageUrls: _selectedImages,
        privacy: _selectedPrivacy,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('投稿を作成しました')),
        );
        context.pop();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('投稿の作成に失敗しました: $error')),
        );
      }
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }
}
```

#### Phase 4: テスト実装

**Test Automation Engineer による統合テスト**:
```dart
// test/integration/sns_integration_test.dart
void main() {
  group('SNS Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          cloudFunctionsProvider.overrideWithValue(MockCloudFunctions()),
          authRepositoryProvider.overrideWithValue(MockAuthRepository()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    testWidgets('投稿作成から表示まで完全フロー', (tester) async {
      // Setup mock responses
      final mockFunctions = container.read(cloudFunctionsProvider) as MockCloudFunctions;
      mockFunctions.setupPostCreate(success: true, postId: 'test-post-1');

      await tester.pumpWidget(
        ProviderScope(
          parent: container,
          child: MaterialApp.router(
            routerConfig: testRouter,
          ),
        ),
      );

      // Navigate to post creation
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Fill post content
      await tester.enterText(find.byType(TextFormField), 'テスト投稿です');

      // Tap post button
      await tester.tap(find.text('投稿'));
      await tester.pumpAndSettle();

      // Verify success
      expect(find.text('投稿を作成しました'), findsOneWidget);

      // Verify navigation back to timeline
      expect(find.text('タイムライン'), findsOneWidget);
    });

    testWidgets('フォロー機能完全フロー', (tester) async {
      // Setup mock data
      final mockFunctions = container.read(cloudFunctionsProvider) as MockCloudFunctions;
      mockFunctions.setupFollowManage(success: true);

      await tester.pumpWidget(createTestApp(container));

      // Navigate to user profile
      await tester.tap(find.text('テストユーザー'));
      await tester.pumpAndSettle();

      // Tap follow button
      await tester.tap(find.text('フォロー'));
      await tester.pumpAndSettle();

      // Verify follow state
      expect(find.text('フォロー中'), findsOneWidget);

      // Verify follow API was called
      verify(mockFunctions.httpsCallable('v2_sns_follow_manage')).called(1);
    });

    testWidgets('リアルタイム投稿更新', (tester) async {
      // Setup stream controller for realtime updates
      final postsStreamController = StreamController<List<Post>>();

      container = ProviderContainer(
        overrides: [
          realtimePostStreamProvider.overrideWith(
            (_) => postsStreamController.stream,
          ),
        ],
      );

      await tester.pumpWidget(createTestApp(container));

      // Verify initial empty state
      expect(find.text('まだ投稿がありません'), findsOneWidget);

      // Add posts to stream
      postsStreamController.add([
        TestDataFactory.createTestPost(id: '1', content: 'リアルタイム投稿1'),
        TestDataFactory.createTestPost(id: '2', content: 'リアルタイム投稿2'),
      ]);

      await tester.pump();

      // Verify posts appear
      expect(find.text('リアルタイム投稿1'), findsOneWidget);
      expect(find.text('リアルタイム投稿2'), findsOneWidget);
    });
  });
}

// Performance test
void main() {
  group('SNS Performance Tests', () {
    testWidgets('タイムライン画面の描画性能', (tester) async {
      final stopwatch = Stopwatch()..start();

      // Create large dataset
      final largePosts = List.generate(100, (index) =>
        TestDataFactory.createTestPost(id: 'post-$index')
      );

      await tester.pumpWidget(
        createTestApp(
          overrides: [
            postNotifierProvider.overrideWith(
              () => AsyncValue.data(PostState(posts: largePosts)),
            ),
          ],
        ),
      );

      await tester.pumpAndSettle();
      stopwatch.stop();

      // Verify performance
      expect(stopwatch.elapsedMilliseconds, lessThan(500)); // 500ms以内
      expect(find.byType(PostCard), findsWidgets);
    });
  });
}
```

### 成果物と統合確認

#### Conductor Agent による最終統合チェック
```yaml
integration_checklist:
  backend_integration:
    - ✅ SNS Cloud Functions deployed successfully
    - ✅ Firestore data models match frontend expectations
    - ✅ Error handling consistent across all functions
    - ✅ Real-time updates working properly

  state_management_integration:
    - ✅ Providers correctly integrate with Cloud Functions
    - ✅ Real-time stream updates working
    - ✅ Error states properly handled
    - ✅ Loading states provide good UX

  ui_integration:
    - ✅ All screens implemented with Material Design 3
    - ✅ Responsive design working across screen sizes
    - ✅ Accessibility compliance achieved
    - ✅ Performance benchmarks met

  testing_integration:
    - ✅ Unit test coverage > 80%
    - ✅ Widget test coverage: 100% of UI components
    - ✅ Integration tests cover critical user flows
    - ✅ Performance tests pass all benchmarks

quality_metrics:
  code_coverage: 85%
  performance_score: 95/100
  accessibility_score: 98/100
  user_flow_completion: 100%
  error_handling_coverage: 92%
```

この例では、各エージェントが専門性を活かして協調的に作業し、高品質なSNS機能を実装する過程を詳細に示しています。リアルタイム機能、状態管理、UI/UX、テストまで包括的にカバーした実装例となっています。