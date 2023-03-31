import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../common/asyncvalue_widget.dart';
import 'user_view_model.dart';

final logger = Logger();

@RoutePage()
class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(userViewModelProvider);
    final viewModel = ref.watch(userViewModelProvider.notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        final photoUrl = data.photoUrl; // ?? 'No Image';
        final email = data.email == null ? 'No Email' : data.email!;
        final displayName =
            data.displayName == null ? 'No DisplayName' : data.displayName!;
        final name = data.name == null ? 'No Name' : data.name!;
        final phone =
            data.phoneNumber == null ? 'No Phone Number' : data.phoneNumber!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            leading: const AutoLeadingButton(),
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (photoUrl != null)
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: CachedNetworkImageProvider(photoUrl),
                        ),
                      const SizedBox(height: 40),
                      Text(
                        email,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        displayName,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        name,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        phone,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: appRoute.pop,
                            child: Text(l10n.cancel),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              appRoute.push(UserEditRoute(uid: data.id!));
                            },
                            child: Text(l10n.edit),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              viewModel.getAccountLink(email);
                            },
                            child: const Text('出品者登録・更新'),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              const url =
                                  'https://dashboard.stripe.com/dashboard';
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(
                                  Uri.parse(url),
                                  webOnlyWindowName: '_self',
                                );
                              } else {
                                logger.e('Could not launch URL');
                                final Error error =
                                    ArgumentError('Error launching $url');
                                throw error;
                              }
                            },
                            child: const Text('管理サイト'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
