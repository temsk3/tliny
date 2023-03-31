import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/ui/auth/auth_view_model.dart';

import '../../../gen/assets.gen.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/routes/app_route.gr.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/drawer/drawer_state.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(
              children: const [
                // QRCodeScanListTile(),
                CustomUserAccountsDrawerHeader(),
                CustomSignListTile(),
                CustomProfileListTile(),
                CustomUsageHistoryListTile(),
                CustomOrderListTile(),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: const Text('Terms'),
            onTap: () {},
          ),
          const CustomAboutListTile(),
        ],
      ),
    );
  }
}

class CustomUserAccountsDrawerHeader extends HookWidget {
  const CustomUserAccountsDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(appThemeProvider);
        return AsyncValueButtonWidget(
          value: ref.watch(userStreamStateProvider),
          data: (data) {
            if (data == null) {
              return Container();
            } else {
              return UserAccountsDrawerHeader(
                decoration: const BoxDecoration(),
                accountName: data.displayName == null
                    ? Text(
                        'non',
                        style: TextStyle(
                          color: theme.mode == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    : Text(
                        data.displayName!,
                        style: TextStyle(
                          color: theme.mode == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                accountEmail: Text(
                  data.email!,
                  style: TextStyle(
                    color: theme.mode == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: data.photoUrl == null
                      ? null
                      : NetworkImage(data.photoUrl!),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class QRCodeScanListTile extends HookWidget {
  const QRCodeScanListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.qr_code_scanner),
                title: const Text('QRCodeScan'),
                onTap: () {
                  appRoute.push(const QRScanRoute());
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class CustomProfileListTile extends HookWidget {
  const CustomProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(l10n.profile),
                onTap: () {
                  appRoute.push(const UserRoute());
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class CustomUsageHistoryListTile extends HookWidget {
  const CustomUsageHistoryListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.history_rounded),
                title: Text(l10n.usageHistory),
                onTap: () {
                  appRoute.push(
                    const UsageHistoryRoute(),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class CustomOrderListTile extends HookWidget {
  const CustomOrderListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('購入履歴'),
                onTap: () {
                  appRoute.push(
                    const OrderRoute(),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}

class CustomSignListTile extends HookWidget {
  const CustomSignListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: const Text('SignOut'),
                onTap: () {
                  ref.read(authViewModelProvider.notifier).signOut();
                },
              );
            } else {
              return ListTile(
                leading: const Icon(Icons.login_outlined),
                title: const Text('SignIn'),
                onTap: () async {
                  await appRoute.replace(
                    SignInRoute(
                      onSigninCallback: (bool bool) {
                        appRoute.replace(const HomeRoute());
                      },
                    ),
                  );
                  // final result = await appRoute.push(
                  //   const SignInRoute(),
                  // );
                  // await appRoute.replace(const HomeRoute());
                },
              );
            }
          },
        );
      },
    );
  }
}

class CustomAboutListTile extends StatelessWidget {
  const CustomAboutListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(getPackageInfoProvider),
          data: (data) {
            return AboutListTile(
              icon: const Icon(Icons.info_outline),
              applicationName: data.appName,
              applicationVersion: data.version,
              applicationIcon: Assets.img.icon32x32.image(),
              applicationLegalese: '2022 Spel1\nsupport@spel1.com',
            );
          },
        );
      },
    );
  }
}
