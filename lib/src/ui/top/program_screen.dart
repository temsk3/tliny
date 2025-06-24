import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../common/asyncvalue_widget.dart';
import '../program/program_state.dart';

// final logger = Logger();

class EventScreen extends HookConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final state = ref.watch(programListStateProvider);
    final current = useState(0);
    final pageController = useState(PageController());

    return AsyncValueWidget(
      value: state,
      data: (data) {
        final list =
            data
                .where(
                  (program) =>
                      program.isActive == true && program.isPublish == true,
                )
                .toList();

        if (list.isEmpty) {
          return Container();
        }

        return Scaffold(
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
                  return FullScreenEventCard(program: event);
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
                              color: Colors.white.withOpacity(
                                current.value == entry.key ? 0.9 : 0.4,
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
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white.withOpacity(0.9),
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
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white.withOpacity(0.9),
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
}

class FullScreenEventCard extends HookConsumerWidget {
  const FullScreenEventCard({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();

    return GestureDetector(
      onTap: () {
        ProgramDetailRoute($extra: program).push(context);
      },
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
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[900],
                      child: const Icon(Icons.error, color: Colors.white),
                    ),
              )
              : Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  'No Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

          // グラデーションオーバーレイ（テキストを読みやすくするため）
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.7),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // 上部のタイトル
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            child: Text(
              program.name!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),

          // イベント情報
          Positioned(
            left: 16,
            right: 16,
            bottom: 64,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   program.name!,
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     shadows: [
                //       Shadow(
                //         offset: Offset(1, 1),
                //         blurRadius: 3,
                //         color: Colors.black54,
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 8),
                Text(
                  '${l10n.salesPeriod}: ${l10n.date(program.salesStart!)}〜${l10n.date(program.salesEnd!)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${l10n.periods}: ${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // スワイプヒントは削除（EventScreenの矢印ボタンに置き換え）
        ],
      ),
    );
  }
}
