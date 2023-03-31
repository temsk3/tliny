import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/model/favorite_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_media_query.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../../settings/theme/app_theme.dart';
import '../../../ui/common/asyncvalue_widget.dart';
import '../../image/image_screen.dart';
import '../../program/program_state.dart';
import '../favorite_view_model.dart';

final logger = Logger();

class FavoriteCard extends HookConsumerWidget {
  const FavoriteCard({super.key, required this.favorite});
  final Favorite favorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final state = ref.watch(programListStateProvider);
    final viewModel = ref.watch(favoriteViewModelProvider.notifier);

    return AsyncValueButtonWidget(
      value: state,
      data: (data) {
        if (data.isNotEmpty) {
          // logger.d(product);
          final program =
              data.firstWhere((element) => element.id == favorite.programId);
          return Card(
            child: ListTile(
              onTap: () {
                appRoute.push(ProgramDetailsRoute(program: program));
              },
              leading: PictureDetailView(picture: program.pictureURL),
              //  (program.pictureURL.isEmpty)
              //     ? Image.asset(
              //         'assets/img/cat.jpg',
              //         fit: BoxFit.fitHeight,
              //       )
              //     : CachedNetworkImage(
              //         imageUrl: program.pictureURL[0],
              //         placeholder: (context, url) =>
              //             const CircularProgressIndicator(),
              //         errorWidget: (context, url, error) =>
              //             const Icon(Icons.error),
              //       ),
              title: Text(program.name.toString()),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                    child: Text(
                      '開催期間 : ${l10n.dataTime(program.eventFrom!)}〜${l10n.dataTime(program.eventTo!)}',
                      style: theme.textTheme.h10,
                    ),
                  ),
                  Text(
                    program.message.toString(),
                    style: theme.textTheme.h10,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
