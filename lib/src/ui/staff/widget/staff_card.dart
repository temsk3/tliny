import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../data/model/staff_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/theme/app_text_theme.dart';
import '../../../settings/theme/app_theme.dart';
import '../../auth/auth_view_model.dart';

final logger = Logger();

class StaffCard extends HookConsumerWidget {
  StaffCard({super.key, required this.staff});
  Staff staff;

  List<bool> isSelected = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  List<IconData> iconList = [
    Icons.ac_unit,
    Icons.call,
    Icons.cake,
    Icons.access_alarm,
    Icons.backspace,
    Icons.calendar_today,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();

    final authState = ref.watch(authViewModelProvider);
    final uid = authState?.uid;

    final dateFormatter =
        DateFormat.yMMMEd(Localizations.localeOf(context).toString());

    final isActive = useState(isSelected);

    Container iconContent() {
      return Container(
        margin: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        height: double.infinity,
        width: double.infinity,
        child: Ink(
          color: Colors.white,
          child: GridView.count(
            primary: true,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(isSelected.length, (index) {
              return InkWell(
                onTap: () {
                  isActive.value[index] = !isActive.value[index];
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: isSelected[index] ? Colors.redAccent : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.redAccent,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    iconList[index],
                    size: 40,
                    color: isSelected[index] ? Colors.white : Colors.redAccent,
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(10),
      elevation: 30,
      child: Column(
        children: [
          ListTile(
            dense: true,
            // leading: Container(
            //   width: 120,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.withOpacity(.5),
            //     borderRadius: BorderRadius.circular(10),
            //     image: staff.pictureURL != null
            //         ? DecorationImage(
            //             fit: BoxFit.cover,
            //             image:
            //                 CachedNetworkImageProvider(program.pictureURL![0]),
            //           )
            //         : null,
            //   ),
            //   child: program.pictureURL == null
            //       ? Center(
            //           child: Text('NoImage', style: theme.textTheme.h20
            //               // .copyWith(color: theme.appColors.onPrimary),
            //               ),
            //         )
            //       : null,
            // ),
            title:
                Text(staff.name.toString(), style: theme.textTheme.h30.bold()),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                iconContent()
                // Text(l10n.periods, style: theme.textTheme.h10),
                // FittedBox(
                //   fit: BoxFit.fitWidth,
                //   child: Text(
                //       ' ${dateFormatter.format(program.eventFrom as DateTime)}〜${dateFormatter.format(program.eventTo as DateTime)}',
                //       style: theme.textTheme.h10),
                // ),
                // const Padding(
                //   padding: EdgeInsets.symmetric(vertical: 2.0),
                // ),
                // Text(program.message.toString(), style: theme.textTheme.h10
                //     // .copyWith(color: theme.appColors.onBackground),
                // ),
              ],
            ),
            // trailing: AddIconButton(
            //   visible: false, //
            //   onPressed: () async {
            //     final result = await showConfirmDialog(
            //       context,
            //       appRoute,
            //       title: "title",
            //       message: 'Do you want to apply for staffs?',
            //       cancelText: l10n.no,
            //       decisionText: l10n.yes,
            //     );
            //     if (result) {
            //       // viewModel.createstaff(
            //       //   bazaarId: event.id.toString(),
            //       //   uid: uid,
            //       //   name: name,
            //       // );
            //     }
            //   },
            //   icon: const Icon(Icons.person_add_alt),
            //   tooltip: 'staff request',
            // ),
            onTap: () {
              // appRoute.push(StaffDetailsRoute(staff: staff));
            },
          ),
        ],
      ),
    );
  }
}
