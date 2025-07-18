import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/routes/routes.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/router_utils.dart';
import '../common/asyncvalue_widget.dart';
import 'components/index.dart';
import 'seller_registration_page.dart';
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

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.profile),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // プロフィールカード
                  UserProfileCard(
                    user: data,
                    onEditPressed: () {
                      UserEditRoute(uid: data.id!).push(context);
                    },
                    showEditButton: false,
                  ),

                  // 出品者登録ページへのボタン
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const SellerRegistrationPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.storefront_outlined),
                        label: const Text('出品者登録・管理'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // アクションボタン
                  UserActionButtons(
                    onBackPressed: () => RouterUtils.safePop(context),
                    onEditPressed: () {
                      UserEditRoute(uid: data.id!).push(context);
                    },
                    showAccountLinkButton: false,
                    showAdminSiteButton: false,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
