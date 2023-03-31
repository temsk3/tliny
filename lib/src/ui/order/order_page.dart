import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tliny/src/data/repository/program_repository.dart';

import '../../data/model/order_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../common/asyncvalue_widget.dart';
import '../common/main_body.dart';
import 'order_view_model.dart';

final logger = Logger();

@RoutePage()
class OrderPage extends HookConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    final state = ref.watch(orderViewModelProvider);
    final viewModel = ref.watch(orderViewModelProvider.notifier);

    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);
        return Scaffold(
          appBar: AppBar(
            title: const Text('購入履歴'),
            leading: const AutoLeadingButton(),
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Center(
                child: data.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final order = data[index];
                          return OrderCard(order: order);
                        },
                      )
                    : Container(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OrderCard extends HookConsumerWidget {
  OrderCard({super.key, required this.order});
  Order order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
    var amount = 0;
    for (final element in order.snapshotProducts!) {
      final sum = element.price! * element.quantity!;
      amount += sum;
    }
    return AsyncValueWidget(
      value: ref.watch(programFutureProvider(order.eventId!)),
      data: (data) {
        return data != null
            ? Card(
                child: Column(
                  children: [
                    Text(
                      data.name.toString(),
                      style: theme.textTheme.h50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Text(
                          '${l10n.dataTime(order.purchaseTime!)} ${l10n.time(order.purchaseTime!)}',
                          style: theme.textTheme.h10,
                        ),
                        const Spacer(),
                        Text(l10n.currency(amount)),
                        const Spacer(),
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: order.snapshotProducts!.length,
                      itemBuilder: (context, index) {
                        final product = order.snapshotProducts![index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name.toString(),
                                  style: theme.textTheme.h10,
                                ),
                                Text(
                                  '${l10n.currency(product.price!)} × ${product.quantity!}',
                                  style: theme.textTheme.h10,
                                )
                              ],
                            ),
                            // subtitle: FittedBox(
                            //   fit: BoxFit.scaleDown,
                            //   alignment: Alignment.topLeft,
                            //   child: Text(
                            //     '${l10n.dataTime(product.expirationFrom!)}〜${l10n.dataTime(product.expirationTo!)}',
                            //     style: theme.textTheme.h10,
                            //   ),
                            // ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
