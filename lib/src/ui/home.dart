import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../settings/hooks/use_l10n.dart';
import '../settings/hooks/use_media_query.dart';
import '../settings/routes/app_route.gr.dart';
import '../settings/theme/app_text_theme.dart';
import '../settings/theme/app_theme.dart';
import 'drawer/drawer.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final appMQ = useMediaQuery();

    return WillPopScope(
      onWillPop: _finishNextPage,
      child: AutoTabsScaffold(
        appBarBuilder: (_, tabsRouter) {
          return AppBar(
            // elevation: 0,
            title: Text(
              'Tliny',
              style: theme.textTheme.h30.melanthios(),
            ),
            centerTitle: true,
            leading: const AutoLeadingButton(),
            actions: const [],
          );
        },
        drawer: appMQ.size.width <= 1024 ? const CustomDrawer() : null,
        // homeIndex: 1,
        routes: const [
          TopRoute(),
          FavoriteRoute(),
          CartRoute(),
          TicketRoute(),
          ProgramRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) {
          return NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: const Icon(Icons.home),
                icon: const Icon(Icons.home_outlined),
                label: l10n.home,
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.favorite),
                icon: const Icon(Icons.favorite_outline),
                label: l10n.favorite,
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.shopping_cart),
                icon: const Icon(Icons.shopping_cart_outlined),
                label: l10n.cart,
              ),
              NavigationDestination(
                selectedIcon: const FaIcon(FontAwesomeIcons.ticketSimple),
                icon: const FaIcon(FontAwesomeIcons.ticket),
                label: l10n.ticket,
              ),
              // NavigationDestination(
              //   selectedIcon: const Icon(Icons.shopping_basket),
              //   icon: const Icon(Icons.shopping_basket_outlined),
              //   label: l10n.product,
              // ),
              // NavigationDestination(
              //   selectedIcon: const Icon(Icons.event),
              //   icon: const Icon(Icons.event_outlined),
              //   label: l10n.event,
              // ),
            ],
          );
        },
      ),
    );
  }
}

Future<bool> _finishNextPage() async {
  return false;
}
