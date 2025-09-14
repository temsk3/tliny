import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/user_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/common/main_body.dart';
import '../image/image_screen.dart';
import '../program/program_details_page.dart';
import '../program/program_view_model.dart';

/// 購入可能なイベント一覧画面
class AvailableEventsPage extends HookConsumerWidget {
  const AvailableEventsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();

    // イベントの状態を取得
    final eventsState = ref.watch(programViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text('${l10n.event}一覧')),
      body: MainBodyWidget(
        width: 400,
        body: AsyncValueWidget<List<Program>>(
          value: eventsState,
          data: (events) {
            // 購入可能なイベントのみをフィルタリング
            final availableEvents =
                events.where((event) {
                  // イベントがアクティブで公開されているもののみ
                  if (event.isActive != true || event.isPublish != true) {
                    return false;
                  }

                  // 販売期間内のイベントのみ
                  final now = DateTime.now();
                  if (event.salesStart != null && event.salesEnd != null) {
                    if (now.isBefore(event.salesStart!) ||
                        now.isAfter(event.salesEnd!)) {
                      return false;
                    }
                  }

                  // イベント期間が終了していないもののみ
                  if (event.eventTo != null) {
                    if (now.isAfter(event.eventTo!)) {
                      return false;
                    }
                  }

                  return true;
                }).toList();

            if (availableEvents.isEmpty) {
              return _buildEmptyEventsWidget(context, l10n);
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(programViewModelProvider);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: availableEvents.length,
                itemBuilder: (context, index) {
                  final event = availableEvents[index];
                  return _buildEventCard(context, event, l10n);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, Program event, dynamic l10n) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // イベント画像
            if (event.pictureURL.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: PictureView(picture: event.pictureURL, index: 0),
                ),
              ),

            const SizedBox(height: 12),

            // イベント名とオーナーアバター
            Row(
              children: [
                if (event.organizerId != null)
                  Consumer(
                    builder: (context, ref, _) {
                      final ownerAsyncValue = ref.watch(
                        publicUserStreamProvider(event.organizerId!),
                      );
                      return ownerAsyncValue.when(
                        data:
                            (owner) => GestureDetector(
                              onTap: () {
                                OwnerDetailRoute(
                                  ownerId: event.organizerId!,
                                ).push(context);
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      owner.profileImageURL != null &&
                                              owner.profileImageURL!.isNotEmpty
                                          ? NetworkImage(owner.profileImageURL!)
                                          : null,
                                  child:
                                      owner.profileImageURL == null ||
                                              owner.profileImageURL!.isEmpty
                                          ? Text(
                                            owner.displayName![0].toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          )
                                          : const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                ),
                              ),
                            ),
                        loading:
                            () => Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 8),
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey,
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        error:
                            (error, stack) => Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ),
                      );
                    },
                  ),
                Expanded(
                  child: Text(
                    event.name ?? 'イベント名なし',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // イベント説明
            if (event.message?.isNotEmpty == true)
              Text(
                event.message!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

            const SizedBox(height: 12),

            // 販売期間
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${l10n.salesPeriod}: ${l10n.date(event.salesStart!)}〜${l10n.date(event.salesEnd!)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // イベント期間
            Row(
              children: [
                Icon(Icons.event, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${l10n.periods}: ${l10n.date(event.eventFrom!)}〜${l10n.date(event.eventTo!)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),

            if (event.place?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              // 開催場所
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${l10n.place}: ${event.place}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 16),

            // イベント詳細ボタン
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // イベント詳細ページに遷移
                  if (event.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProgramDetailsPage(program: event),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('詳細を見る'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEventsWidget(BuildContext context, dynamic l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            '購入可能なイベントがありません',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            '現在開催中のイベントがありません',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
