import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/routes/routes.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../common/asyncvalue_widget.dart';
import 'user_view_model.dart';

// final logger = Logger();

// @RoutePage()
class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(userViewModelProvider);
    final viewModel = ref.watch(userViewModelProvider.notifier);

    // スプラッシュスクリーン表示終了
    FlutterNativeSplash.remove();

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
            title: Text(l10n.profile),
            // leading: const AutoLeadingButton(),
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
                            onPressed: () =>
                                // appRoute.replaceAll([const HomeRoute()]),
                                context.pop(),
                            // appRoute.navigate(AppRoutes.mainPage),
                            child: Text(l10n.backButton),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // appRoute.navigate(UserEditRoute(uid: data.id!));
                              UserEditRoute(uid: data.id!).push(context);
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
                            onPressed: () async {
                              await viewModel.getAccountLink(email);
                            },
                            child: const Text('出品者登録・更新'),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              // const url =
                              //     'https://dashboard.stripe.com/dashboard';
                              // if (await canLaunchUrl(Uri.parse(url))) {
                              //   await launchUrl(
                              //     Uri.parse(url),
                              //     webOnlyWindowName: '_self',
                              //   );
                              // } else {
                              //   logger.e('Could not launch URL');
                              //   final Error error =
                              //       ArgumentError('Error launching $url');
                              //   throw error;
                              // }
                              await viewModel.createLoginLink();
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
