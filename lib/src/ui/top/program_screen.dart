import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tliny/src/settings/routes/app_route.gr.dart';

import '../../data/model/program_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../common/asyncvalue_widget.dart';
import '../program/program_state.dart';
import '../program/program_view_model.dart';

final logger = Logger();

class EventScreen extends HookConsumerWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();

    final state = ref.watch(programListStateProvider);

    final current = useState(0);
    final controller = useState(CarouselController());

    return AsyncValueWidget(
      value: state,
      data: (data) {
        final list = data
            .where(
              (program) =>
                  program.isActive == true || program.isPublish == true,
            )
            .toList();

        return data.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.event),
                  const SizedBox(
                    height: 32,
                  ),
                  CarouselSlider.builder(
                    carouselController: controller.value,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) => current.value = index,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index, realIndex) {
                      final event = list[index];
                      return CustomEventCard(program: event);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: list.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => controller.value.animateToPage(entry.key),
                        child: Container(
                          width: 12,
                          height: 12,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.appColors.primary
                                // color: (Theme.of(context).brightness == Brightness.dark
                                // ? Colors.white
                                // : Colors.black)
                                .withOpacity(
                              current.value == entry.key ? 0.9 : 0.4,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              )
            : Container();
      },
    );
  }
}

class CustomEventCard extends HookConsumerWidget {
  CustomEventCard({super.key, required this.program});
  Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final viewModel = ref.watch(programViewModelProvider.notifier);

    return InkWell(
      onTap: () {
        appRoute.push(ProgramDetailsRoute(program: program));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            SizedBox.expand(
              child: program.pictureURL.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: program.pictureURL[0],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : null,
            ),
            ListTile(
              title: Text(program.name!),
              subtitle: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topLeft,
                child: Text(
                  '${l10n.dataTime(program.eventFrom!)}〜${l10n.dataTime(program.eventTo!)}',
                  style: theme.textTheme.h10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
