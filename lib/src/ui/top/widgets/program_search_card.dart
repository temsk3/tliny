import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/program_model.dart';
import '../../../data/repository/user_repository.dart';
import '../../../settings/routes/routes.dart';

class ProgramSearchCard extends ConsumerWidget {
  const ProgramSearchCard({super.key, required this.program});

  final Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (program.id != null) {
              ProgramDetailRoute($extra: program).push(context);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 左側：画像
              if (program.pictureURL.isNotEmpty)
                Container(
                  width: 120,
                  height: 140,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      program.pictureURL.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                          ),
                          child: Icon(
                            Icons.image,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 32,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              else
                Container(
                  width: 120,
                  height: 140,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: Icon(
                    Icons.event,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 32,
                  ),
                ),
              // 中央：コンテンツ
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // タイトル
                      Text(
                        program.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (program.message != null &&
                          program.message!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            program.message!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      if (program.salesStart != null &&
                          program.salesEnd != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '販売期間: ${program.salesStart!.year}/${program.salesStart!.month}/${program.salesStart!.day} - ${program.salesEnd!.year}/${program.salesEnd!.month}/${program.salesEnd!.day}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (program.eventFrom != null && program.eventTo != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.event,
                                size: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '開催期間: ${program.eventFrom!.year}/${program.eventFrom!.month}/${program.eventFrom!.day} - ${program.eventTo!.year}/${program.eventTo!.month}/${program.eventTo!.day}',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (program.place != null && program.place!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  program.place!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // 右端：主催者情報
              if (program.organizerId != null &&
                  program.organizerId!.isNotEmpty)
                Container(
                  width: 80,
                  padding: const EdgeInsets.all(12),
                  child: Consumer(
                    builder: (context, ref, _) {
                      final userAsync = ref.watch(
                        publicUserStreamProvider(program.organizerId!),
                      );
                      return userAsync.when(
                        data: (user) {
                          return GestureDetector(
                            onTap: () {
                              if (user.id != null) {
                                OwnerDetailRoute(
                                  ownerId: user.id!,
                                ).push(context);
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // イベント状態インジケーター
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        program.isPublish == true &&
                                                program.isActive == true
                                            ? Colors.green.withOpacity(0.8)
                                            : Colors.grey.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    program.isPublish == true &&
                                            program.isActive == true
                                        ? '公開中'
                                        : '非公開',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (user.profileImageURL != null &&
                                    user.profileImageURL!.isNotEmpty)
                                  ClipOval(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        user.profileImageURL!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return CircleAvatar(
                                            radius: 20,
                                            backgroundColor:
                                                Theme.of(context)
                                                    .colorScheme
                                                    .surfaceContainerHighest,
                                            child: Icon(
                                              Icons.person,
                                              size: 20,
                                              color:
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                else
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Theme.of(
                                          context,
                                        ).colorScheme.surfaceContainerHighest,
                                    child: Text(
                                      (user.displayName?.isNotEmpty ?? false)
                                          ? user.displayName!.substring(0, 1)
                                          : '?',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  user.displayName ?? '主催者',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                        loading:
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                  child: const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '読み込み中...',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                        error:
                            (e, st) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.person,
                                    size: 20,
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '主催者',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
