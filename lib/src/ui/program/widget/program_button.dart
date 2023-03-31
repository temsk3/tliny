import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/ui/favorite/favorite_view_model.dart';
import 'package:tliny/src/ui/staff/staff_view_model.dart';

import '../../../data/model/favorite_model.dart';
import '../../../data/model/program_model.dart';
import '../../../data/repository/favorite_repository.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/hooks/use_router.dart';
import '../../../settings/routes/app_route.gr.dart';
import '../../../settings/theme/app_theme.dart';
import '../../common/asyncvalue_widget.dart';
import '../../common/base_button_widget.dart';
import '../../common/custom_alert_dialog.dart';
import '../program_state.dart';
import '../program_view_model.dart';

final logger = Logger();

class AddProgramFloatingActionButton extends HookWidget {
  const AddProgramFloatingActionButton({
    super.key,
    // required this.onPressed,
  });
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    return Consumer(
      child: const Icon(Icons.add_sharp),
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(addProgramButtonStateProvider),
          data: (visible) {
            if (visible) {
              return BaseFloatingActionButton(
                onPressed: () async {
                  await appRoute
                      .push(ProgramEditRoute(program: Program.empty()));
                },
                child: child!,
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

class DeleteProgramIconButton extends HookWidget {
  const DeleteProgramIconButton({
    super.key,
    required this.program,
    // required this.onPressed,
  });
  final Program program;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(editProgramButtonStateProvider(program)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                tooltip: l10n.delete,
                onPressed: () async {
                  final result = await showConfirmDialog(
                    context,
                    appRoute,
                    cancelText: l10n.no,
                    decisionText: l10n.yes,
                    contentWidget: const Text('Do you want to delete it?'),
                    title: 'delete',
                  );
                  if (result!) {
                    await Fluttertoast.showToast(
                      msg: 'Processing Data',
                      fontSize: 14,
                    );
                    await ref
                        .watch(programViewModelProvider.notifier)
                        .deleteProgram(
                          program.id.toString(),
                        );
                    appRoute.popUntilRoot();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

class EditProgramIconButton extends HookWidget {
  const EditProgramIconButton({
    super.key,
    required this.program,
    // required this.onPressed,
  });
  final Program program;
  // final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      child: BaseIconButton(
        icon: const Icon(
          Icons.edit,
        ),
        tooltip: l10n.edit,
        onPressed: () async {
          await appRoute.push(ProgramEditRoute(program: program));
        },
      ),
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(editProgramButtonStateProvider(program)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: child!,
            );
          },
        );
      },
    );
  }
}

class AddStaffIconButton extends HookWidget {
  const AddStaffIconButton({
    super.key,
    required this.program,
  });
  final Program program;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    final controller = useTextEditingController();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(
            addStaffButtonStateProvider(program),
          ), //ref.watch(editProgramButtonStateProvider(program)
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: const Icon(
                  Icons.person_add_alt,
                  size: 16,
                ),
                tooltip: 'staff request',
                onPressed: () async {
                  final result = await showConfirmDialog(
                    context,
                    appRoute,
                    title: 'Do you want to apply for staffs?',
                    contentWidget: TextFormField(
                      autofocus: true,
                      controller: controller,
                    ),
                    cancelText: l10n.no,
                    decisionText: l10n.yes,
                  );
                  if (result!) {
                    if (program.staffCode == controller.text) {
                      await ref
                          .watch(staffViewModelProvider(program.id!).notifier)
                          .addStaff(program.id!);
                      await appRoute.pop();
                    }
                    if (context.mounted) {
                      await showTextDialog(
                        context,
                        appRoute,
                        title: 'confirm',
                        message: 'the code is wrong',
                        defaultActionText: l10n.ok,
                      );
                    }
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

// class AddProductFloatingActionButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const AddProductFloatingActionButton({
//     super.key,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       child: const Icon(Icons.add_sharp),
//       builder: (context, ref, child) {
//         return AsyncValueWidget(
//           value: ref.watch(addProgramButtonStateProvider),
//           data: (visible) {
//             if (visible) {
//               return Expanded(
//                 child: BaseFloatingActionButton(
//                   onPressed: onPressed,
//                   child: child!,
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         );
//       },
//     );
//   }
// }

class RegisterProgramElevatedButton extends HookWidget {
  const RegisterProgramElevatedButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.register),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: onPressed,
          child: child!,
        );
      },
    );
  }
}

class CancelElevatedButton extends HookWidget {
  const CancelElevatedButton({super.key});
  @override
  Widget build(BuildContext context) {
    final appRoute = useRouter();
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.cancel),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: appRoute.pop,
          child: child!,
        );
      },
    );
  }
}

class FavoriteProgramIconButton extends HookConsumerWidget {
  const FavoriteProgramIconButton({
    super.key,
    required this.programId,
  });
  final String programId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    // final icon = useState(Icons.favorite_outline);
    // final onPressed = useState(() {});
    IconData icon;
    VoidCallback onPressed;
    return AsyncValueButtonWidget(
      value: ref.watch(authStateChangesProvider),
      data: (visible) {
        return AsyncValueButtonWidget(
          value: ref.watch(favoriteCheckExistenceProvider(programId)),
          data: (favorite) {
            if (favorite) {
              icon = Icons.favorite;
              onPressed = () {
                ref
                    .watch(favoriteViewModelProvider.notifier)
                    .deleteFavorite(programId);
              };
            } else {
              icon = Icons.favorite_outline;
              onPressed = () {
                ref
                    .watch(favoriteViewModelProvider.notifier)
                    .addFavorite(Favorite(programId: programId));
              };
            }
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: Icon(
                  icon,
                  color: ref.watch(appThemeProvider).appColors.secondary,
                ),
                tooltip: l10n.favorite,
                onPressed: onPressed,
              ),
            );
          },
        );
      },
    );
  }
}

class QRCodeScanIconButton extends HookWidget {
  const QRCodeScanIconButton({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(editProgramButtonStateProvider(program)),
          data: (data) {
            if (data) {
              return BaseIconButton(
                icon: const Icon(Icons.qr_code_scanner),
                tooltip: 'QRCodeScan',
                onPressed: () {
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
