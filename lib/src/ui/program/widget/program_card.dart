import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/program_model.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../image/image_screen.dart';
import '../program_view_model.dart';
import 'program_button.dart';

// final logger = Logger();

class EventCard extends HookConsumerWidget {
  EventCard({super.key, required this.program});
  // int index;
  Program program;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final viewModel = ref.watch(programViewModelProvider.notifier);

    // final authState = ref.watch(authViewModelProvider);
    // final uid = authState?.uid;

    // final DateFormat dateFormatter =
    //     DateFormat.yMMMEd(Localizations.localeOf(context).toString());

    return
    // Expanded(
    //   child:
    //       // Card(
    //       //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //       //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //       //   margin: const EdgeInsets.all(10.0),
    //       //   elevation: 30.0,
    //       //   child:
    //       //  Column(
    //       //   children: [
    //       ListTile(
    //     dense: true,
    //     leading: Container(
    //       width: 120,
    //       //   decoration: BoxDecoration(
    //       //     color: Colors.grey.withOpacity(.5),
    //       //     borderRadius: BorderRadius.circular(10),
    //       //     image: program.pictureURL != null
    //       //         ? DecorationImage(
    //       //             fit: BoxFit.cover,
    //       //             image:
    //       //                 CachedNetworkImageProvider(program.pictureURL![0]),
    //       //           )
    //       //         : null,
    //       //   ),
    //       //   child: program.pictureURL == null
    //       //       ? Center(
    //       //           child: Text('NoImage', style: theme.textTheme.h20
    //       //               // .copyWith(color: theme.appColors.onPrimary),
    //       //               ),
    //       //         )
    //       //       : null,
    //     ),
    //     title: Text(program.name.toString(), style: theme.textTheme.h30.bold()),
    //     subtitle: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(l10n.periods, style: theme.textTheme.h10),
    //         FittedBox(
    //           fit: BoxFit.fitWidth,
    //           child: Text(
    //               ' ${dateFormatter.format(program.eventFrom as DateTime)}〜${dateFormatter.format(program.eventTo as DateTime)}',
    //               style: theme.textTheme.h10),
    //         ),
    //         const Padding(
    //           padding: EdgeInsets.symmetric(vertical: 2.0),
    //         ),
    //         Text(program.message.toString(), style: theme.textTheme.h10),
    //       ],
    //     ),
    //     trailing: AddStaffIconButton(
    //       onPressed: () async {
    //         final result = await showConfirmDialog(
    //           context,
    //           appRoute,
    //           title: "title",
    //           message: 'Do you want to apply for staffs?',
    //           cancelText: l10n.no,
    //           decisionText: l10n.yes,
    //         );
    //         if (result) {
    //           // viewModel.createstaff(
    //           //   bazaarId: event.id.toString(),
    //           //   uid: uid,
    //           //   name: name,
    //           // );
    //         }
    //       },
    //       icon: const Icon(Icons.person_add_alt),
    //       tooltip: 'staff request',
    //     ),
    //     onTap: () {
    //       appRoute.push(ProgramDetailsRoute(program: program));
    //     },
    //     // ),
    //     //   ],
    //     // ),
    //   ),
    // );
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          // appRoute.push(ProgramDetailsRoute(program: program));
          if (program.id != null) {
            ProgramDetailRoute($extra: program).push(context);
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Expanded(
            //   flex: 2,
            //   child:
            Flexible(
              // flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    decoration: const BoxDecoration(color: Colors.blue),
                    child: PictureView(
                      picture: program.pictureURL,
                      index: 0,
                      tap: false,
                    ),
                  ),
                  // FavoriteProgramIconButton(
                  //   programId: program.id!,
                  // )
                ],
              ),
            ),
            // ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      program.name.toString(),
                      // style: theme.textTheme.h20.bold(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
                    Text(
                      l10n.periods,
                      // style: theme.textTheme.h10,
                    ),
                    // const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Row(
                      children: [
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '${l10n.date(program.eventFrom!)}〜${l10n.date(program.eventTo!)}',
                            // style: theme.textTheme.h10,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
                    Text(
                      program.message.toString(),
                      // style: theme.textTheme.h10,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  //
                  Expanded(child: EditProgramIconButton(program: program)),
                  Expanded(child: DeleteProgramIconButton(program: program)),
                  Expanded(child: AddStaffIconButton(program: program)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
