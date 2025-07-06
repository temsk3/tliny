import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/l10n/app_localizations.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/user_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import '../program/program_state.dart';
import '../program/widget/program_button.dart';

// final logger = Logger();

class EventScreen extends HookConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final state = ref.watch(programsStateProvider);
    final current = useState(0);
    final pageController = useState(PageController());

    return AsyncValueWidget(
      value: state,
      data: (data) {
        final now = DateTime.now();
        final list =
            data
                .where(
                  (program) =>
                      program.isActive == true &&
                      program.isPublish == true &&
                      // 開催期間の過ぎたイベントは表示しない
                      program.eventTo != null &&
                      program.eventTo!.isAfter(now),
                )
                .toList();

        if (list.isEmpty) {
          return _buildEmptyEventsWidget(context, l10n);
        }

        return Scaffold(
          floatingActionButton: const AddProgramFloatingActionButton(
            heroTag: 'program_screen_fab',
          ),
          body: Stack(
            children: [
              // フルスクリーンのPageView
              PageView.builder(
                controller: pageController.value,
                scrollDirection: Axis.vertical, // 縦方向のスワイプ（TikTokスタイル）
                onPageChanged: (index) => current.value = index,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final event = list[index];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: FullScreenEventCard(program: event),
                  );
                },
              ),

              // // 上部のタイトル
              // Positioned(
              //   top: MediaQuery.of(context).padding.top + 16,
              //   left: 16,
              //   child: Text(
              //     l10n.event,
              //     style: const TextStyle(
              //       color: Colors.white,
              //       fontSize: 20,
              //       fontWeight: FontWeight.bold,
              //       shadows: [
              //         Shadow(
              //           offset: Offset(1, 1),
              //           blurRadius: 3,
              //           color: Colors.black54,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // 右側のインジケーター
              Positioned(
                right: 16,
                bottom:
                    MediaQuery.of(context).size.height / 2 - (list.length * 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      list.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap:
                              () => pageController.value.animateToPage(
                                entry.key,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(
                                alpha: current.value == entry.key ? 0.9 : 0.4,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),

              // 上部中央の矢印（前のイベントに移動）
              if (current.value > 0)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        pageController.value.animateToPage(
                          current.value - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),

              // 下部中央の矢印（次のイベントに移動）
              if (current.value < list.length - 1)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        pageController.value.animateToPage(
                          current.value + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyEventsWidget(BuildContext context, AppLocalizations l10n) {
    return Scaffold(
      floatingActionButton: const AddProgramFloatingActionButton(
        heroTag: 'program_screen_empty_fab',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              'イベントがありません',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              '新しいイベントがここに表示されます',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenEventCard extends HookConsumerWidget {
  const FullScreenEventCard({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();

    // オーナー情報を取得
    final ownerAsyncValue =
        program.organizerId != null
            ? ref.watch(publicUserStreamProvider(program.organizerId!))
            : null;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 背景画像
          program.pictureURL.isNotEmpty
              ? CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: program.pictureURL[0],
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  logger.e('CachedNetworkImage error: $error');
                  return Container(
                    color: Colors.grey[900],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.white),
                        const SizedBox(height: 8),
                        Text(
                          '画像読み込みエラー',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              : Container(
                alignment: Alignment.center,
                color: Colors.grey[900],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No Image',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

          // グラデーションオーバーレイ（テキストを読みやすくするため）
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0),
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),

          // オーナーアバター（タイトルの左側）
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 20,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (program.organizerId != null) {
                  OwnerDetailRoute(ownerId: program.organizerId!).push(context);
                }
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child:
                      ownerAsyncValue?.when(
                        data:
                            (owner) => CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[300],
                              backgroundImage:
                                  owner.profileImageURL != null &&
                                          owner.profileImageURL!.isNotEmpty
                                      ? CachedNetworkImageProvider(
                                        owner.profileImageURL!,
                                      )
                                      : null,
                              child:
                                  owner.profileImageURL == null ||
                                          owner.profileImageURL!.isEmpty
                                      ? (owner.displayName != null &&
                                              owner.displayName!.isNotEmpty
                                          ? Text(
                                            owner.displayName![0].toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                          : const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 20,
                                          ))
                                      : null,
                            ),
                        loading:
                            () => const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        error:
                            (error, stack) => CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                      ) ??
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                ),
              ),
            ),
          ),

          // 上部のタイトル
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 80, // オーナーアバターの右側から開始
            right: 20,
            child: Text(
              program.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),

          // イベント情報（右下）
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.salesPeriod,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${l10n.date(program.salesStart!)}〜${l10n.date(program.salesEnd!)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.event,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.periods,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 開催場所
                  if (program.place != null && program.place!.isNotEmpty) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white.withValues(alpha: 0.8),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '開催場所',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      program.place!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // 全体のタップ領域（オーナーアバターの領域を除外）
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                if (program.id != null) {
                  ProgramDetailRoute($extra: program).push(context);
                }
              },
              child: Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 108, left: 68),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
