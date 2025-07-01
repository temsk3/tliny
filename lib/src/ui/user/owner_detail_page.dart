import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/model/program_model.dart';
import '../../data/repository/program_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/routes/routes.dart';
import '../common/asyncvalue_widget.dart';

// オーナーのイベント一覧を取得するプロバイダー
final AutoDisposeStreamProviderFamily<List<Program>, String>
ownerProgramsProvider = StreamProvider.autoDispose
    .family<List<Program>, String>((ref, ownerId) {
      final programRepository = ref.watch(programRepositoryProvider);
      return programRepository.watchEventsByOrganizer(ownerId);
    });

class OwnerDetailPage extends HookConsumerWidget {
  const OwnerDetailPage({super.key, required this.ownerId});
  final String ownerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final ownerAsyncValue = ref.watch(publicUserStreamProvider(ownerId));

    // リポジトリを直接使用してイベント一覧を取得
    final programRepository = ref.watch(programRepositoryProvider);
    final ownerProgramsAsyncValue = ref.watch(ownerProgramsProvider(ownerId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1a1a1a), Color(0xFF2d2d2d)],
          ),
        ),
        child: AsyncValueWidget(
          value: ownerAsyncValue,
          data: (owner) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // ヘッダー部分
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
                    child: Column(
                      children: [
                        // プロフィール画像
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 60,
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
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                        : const Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                          size: 60,
                                        ))
                                    : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // 表示名
                        if (owner.displayName != null &&
                            owner.displayName!.isNotEmpty)
                          Text(
                            owner.displayName!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(height: 8),
                        // 作成日
                        if (owner.createdAt != null)
                          Text(
                            '${l10n.memberSince}: ${l10n.date(owner.createdAt!)}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),

                  // 情報カード
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.profile,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // 表示名
                        if (owner.displayName != null &&
                            owner.displayName!.isNotEmpty) ...[
                          _buildInfoRow(l10n.displayName, owner.displayName!),
                          const SizedBox(height: 12),
                        ],
                        // 作成日
                        if (owner.createdAt != null) ...[
                          _buildInfoRow(
                            l10n.memberSince,
                            l10n.date(owner.createdAt!),
                          ),
                          const SizedBox(height: 12),
                        ],
                        // 更新日
                        if (owner.updatedAt != null) ...[
                          _buildInfoRow(
                            l10n.lastUpdated,
                            l10n.date(owner.updatedAt!),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 作成したイベント一覧
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.event,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '作成したイベント',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ownerProgramsAsyncValue.when(
                          loading: () {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          error: (error, stack) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red[400],
                                    size: 48,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'エラーが発生しました',
                                    style: TextStyle(
                                      color: Colors.red[400],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          data: (programs) {
                            if (programs.isEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      color: Colors.grey[400],
                                      size: 48,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '作成したイベントはありません',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children:
                                  programs.map((program) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            if (program.id != null) {
                                              ProgramDetailRoute(
                                                $extra: program,
                                              ).push(context);
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // イベント画像
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withValues(
                                                              alpha: 0.2,
                                                            ),
                                                        blurRadius: 4,
                                                        offset: const Offset(
                                                          0,
                                                          2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  child:
                                                      program
                                                              .pictureURL
                                                              .isNotEmpty
                                                          ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                            child: CachedNetworkImage(
                                                              imageUrl:
                                                                  program
                                                                      .pictureURL[0],
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                              placeholder:
                                                                  (
                                                                    context,
                                                                    url,
                                                                  ) => Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          Colors
                                                                              .grey[600],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                    ),
                                                                    child: const Center(
                                                                      child: CircularProgressIndicator(
                                                                        strokeWidth:
                                                                            2,
                                                                        valueColor: AlwaysStoppedAnimation<
                                                                          Color
                                                                        >(
                                                                          Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                              errorWidget:
                                                                  (
                                                                    context,
                                                                    url,
                                                                    error,
                                                                  ) => Container(
                                                                    width: 80,
                                                                    height: 80,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                          Colors
                                                                              .grey[600],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            12,
                                                                          ),
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons
                                                                          .event,
                                                                      color:
                                                                          Colors
                                                                              .grey,
                                                                      size: 32,
                                                                    ),
                                                                  ),
                                                            ),
                                                          )
                                                          : Container(
                                                            width: 80,
                                                            height: 80,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors
                                                                      .grey[600],
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                            ),
                                                            child: const Icon(
                                                              Icons.event,
                                                              color:
                                                                  Colors.grey,
                                                              size: 32,
                                                            ),
                                                          ),
                                                ),
                                                const SizedBox(width: 16),
                                                // イベント情報
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // イベント名
                                                      Text(
                                                        program.name ??
                                                            '無題のイベント',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      // イベント情報
                                                      if (program.salesStart !=
                                                              null &&
                                                          program.salesEnd !=
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                bottom: 4,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.schedule,
                                                                color:
                                                                    Colors
                                                                        .grey[400],
                                                                size: 14,
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  '販売期間: ${l10n.date(program.salesStart!)}〜${l10n.date(program.salesEnd!)}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .grey[300],
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (program.eventFrom !=
                                                              null &&
                                                          program.eventTo !=
                                                              null)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                bottom: 4,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.event,
                                                                color:
                                                                    Colors
                                                                        .grey[400],
                                                                size: 14,
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  '開催期間: ${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .grey[300],
                                                                    fontSize:
                                                                        13,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      if (program.place !=
                                                              null &&
                                                          program
                                                              .place!
                                                              .isNotEmpty)
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors
                                                                      .grey[400],
                                                              size: 14,
                                                            ),
                                                            const SizedBox(
                                                              width: 6,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                '開催地: ${program.place}',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .grey[300],
                                                                  fontSize: 13,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                // 矢印アイコン
                                                const Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.grey,
                                                  size: 24,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
