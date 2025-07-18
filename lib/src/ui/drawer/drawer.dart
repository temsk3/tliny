import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/settings/routes/routes.dart';

import '../../../gen/assets.gen.dart';
import '../../data/repository/auth_repository.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../ui/auth/auth_view_model.dart';
import '../../ui/common/asyncvalue_widget.dart';
import '../../ui/drawer/drawer_state.dart';
import '../../ui/program/program_state.dart';
import '../my_program/my_program_view_model.dart';

class CustomDrawer extends HookConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    // final appMQ = useMediaQuery();
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Assets.img.icon.image(height: 16, width: 16),
                      const SizedBox(width: 4),
                      Text(l10n.appTitle),
                    ],
                  ),
                ),
                const CustomUserAccountsDrawerHeader(),
                const CustomSignListTile(),
                const CustomProfileListTile(),
                const CustomUsageHistoryListTile(),
                const CustomOrderListTile(),
                const CustomMyEventListTile(),
                const CustomManagementListTile(),
              ],
            ),
          ),
          const CustomTermsListTile(),
          const CustomAboutListTile(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class CustomMyEventListTile extends HookWidget {
  const CustomMyEventListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(myProgramViewModelProvider),
          data: (myProgramList) {
            final widgetList = <Widget>[];
            final program = ref.watch(programsStateProvider).value;
            if (program != null) {
              for (final myProgram in myProgramList) {
                final programData = program.firstWhere(
                  (element) => element.id == myProgram.id,
                );
                final widget = ListTile(
                  onTap: () {
                    ProgramDetailRoute($extra: programData).push<void>(context);
                  },
                  title: Text(programData.name ?? ''),
                );
                widgetList.add(widget);
              }
              return widgetList.isEmpty
                  ? Container()
                  : ExpansionTile(
                    title: const Text('My Event'),
                    children: widgetList,
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

class CustomManagementListTile extends HookWidget {
  const CustomManagementListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              final list = ref.watch(myProgramListStateProvider).value;
              final widgetList = <Widget>[];
              if (list != null) {
                for (final element in list) {
                  final widget = ListTile(
                    onTap:
                        () =>
                        // appRoute.push(ManagementRoute(eventId: element.id!))
                        ManagementRoute(
                          eventId: element.id!,
                        ).push<void>(context),
                    title: Text(element.name.toString()),
                  );
                  widgetList.add(widget);
                }
              }

              return widgetList.isEmpty
                  ? Container()
                  : ExpansionTile(
                    title: Text(l10n.salesInformation),
                    // leading: const Icon(Icons.cancel),
                    children: widgetList,
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

class CustomUserAccountsDrawerHeader extends HookWidget {
  const CustomUserAccountsDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(userStreamStateProvider),
          data: (data) {
            if (data == null) {
              return Container();
            } else {
              return UserAccountsDrawerHeader(
                // decoration: const BoxDecoration(),
                // onDetailsPressed: () => appRoute.push(const UserRoute()),
                accountName:
                    data.displayName == null
                        ? const Text('non')
                        : Text(data.displayName!),
                accountEmail: Text(data.email!),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      data.photoUrl == null
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

class CustomProfileListTile extends HookWidget {
  const CustomProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
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
                  // appRoute.push(const UserRoute());
                  const UserRoute().push<void>(context);
                },
              );
            } else {
              return const SizedBox.shrink();
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
    // final appRoute = useRouter();
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
                  // appRoute.push(
                  //   const UsageHistoryRoute(),
                  // );
                  const UsageHistoryRoute().push<void>(context);
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
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.history_rounded),
                title: Text(l10n.purchaseHistory),
                onTap: () {
                  // appRoute.push(
                  //   const OrderRoute(),
                  // );
                  const OrderRoute().push<void>(context);
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
    final l10n = useL10n();
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(authStateChangesProvider),
          data: (data) {
            if (data) {
              return ListTile(
                leading: const Icon(Icons.logout_outlined),
                title: Text(l10n.signOut),
                onTap: () {
                  ref.read(authViewModelProvider.notifier).signOut();
                },
              );
            } else {
              return ListTile(
                leading: const Icon(Icons.login_outlined),
                title: Text(l10n.signIn),
                onTap: () async {
                  // await appRoute.replace(
                  //   SignInRoute(
                  //     onSigninCallback: (bool bool) {
                  //       appRoute.replace(const HomeRoute());
                  // },
                  //   ),
                  // );
                  context.push(AppRoutes.signInPage);
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
              applicationIcon: Assets.img.icon.image(scale: 16),
              // applicationLegalese: '2022 Spel1\nsupport@spel1.com',
            );
          },
        );
      },
    );
  }
}

class CustomTermsListTile extends HookWidget {
  const CustomTermsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    return ListTile(
      leading: const Icon(Icons.library_books_outlined),
      title: const Text('Terms'),
      onTap: () async {
        final txtContent = await rootBundle.loadString(
          'assets/files/TLINY_terms.txt',
        );
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Terms'),
              content: SingleChildScrollView(child: Text(txtContent)),
              actions: [
                TextButton(
                  child: Text(l10n.close),
                  onPressed: () {
                    // appRoute.pop(false);
                    context.pop(false);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CustomCommerceListTile extends HookWidget {
  const CustomCommerceListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    return ListTile(
      leading: const Icon(Icons.library_books_outlined),
      title: Text(l10n.specificCommercialCode),
      onTap: () async {
        final txtContent = await rootBundle.loadString(
          'assets/files/TLINY_commerce.txt',
        );
        await showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(l10n.specificCommercialCode),
              content: SingleChildScrollView(child: Text(txtContent)),
              actions: [
                TextButton(
                  child: Text(l10n.close),
                  onPressed: () {
                    // appRoute.pop(false);
                    context.pop(false);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
