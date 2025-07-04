import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/data/repository/auth_repository.dart';
import 'package:tliny/src/ui/favorite/favorite_view_model.dart';
import 'package:tliny/src/ui/staff/staff_view_model.dart';

import '../../../data/model/favorite_model.dart';
import '../../../data/model/program_model.dart';
import '../../../data/repository/favorite_repository.dart';
import '../../../settings/hooks/use_l10n.dart';
import '../../../settings/routes/routes.dart';
import '../../../utils/router_utils.dart';
import '../../common/asyncvalue_widget.dart';
import '../../common/base_button_widget.dart';
import '../../common/custom_alert_dialog.dart';
import '../../product/product_state.dart';
import '../program_state.dart';
import '../program_view_model.dart';

// final logger = Logger();

class AddProgramFloatingActionButton extends HookWidget {
  const AddProgramFloatingActionButton({
    super.key,
    this.heroTag,
    // required this.onPressed,
  });
  // final VoidCallback onPressed;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    // final appRoute = useRouter();
    return Consumer(
      child: const Icon(Icons.add_sharp),
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(addProgramButtonStateProvider),
          data: (visible) {
            if (visible) {
              return BaseFloatingActionButton(
                heroTag: heroTag ?? 'add_program_fab',
                onPressed: () async {
                  // await appRoute
                  //     .push(ProgramEditRoute(program: Program.empty()));
                  ProgramEditRoute($extra: Program.empty()).push(context);
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
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(editProgramButtonStateProvider(program)),
          data: (visible) {
            return Visibility(
              visible: visible,
              child: BaseIconButton(
                icon: const Icon(Icons.delete),
                tooltip: l10n.delete,
                onPressed: () async {
                  final result = await showConfirmDialog(
                    context,
                    // appRoute,
                    cancelText: l10n.no,
                    decisionText: l10n.yes,
                    contentWidget: Text(l10n.doYouWantToDeleteIt),
                    title: l10n.delete,
                  );
                  if (result!) {
                    // await showFluttertoast('Processing Data');
                    await ref
                        .watch(programViewModelProvider.notifier)
                        .deleteProgram(program.id.toString());
                    // appRoute.popUntilRoot();
                    RouterUtils.safePop(context);
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
    // final appRoute = useRouter();
    return Consumer(
      child: BaseIconButton(
        icon: const Icon(Icons.edit),
        tooltip: l10n.edit,
        onPressed: () async {
          // await appRoute.push(ProgramEditRoute(program: program));
          ProgramEditRoute($extra: program).push(context);
        },
      ),
      builder: (context, ref, child) {
        return AsyncValueWidget(
          value: ref.watch(editProgramButtonStateProvider(program)),
          data: (visible) {
            return Visibility(visible: visible, child: child!);
          },
        );
      },
    );
  }
}

class AddStaffIconButton extends HookWidget {
  const AddStaffIconButton({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
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
                icon: const Icon(Icons.person_add_alt, size: 16),
                tooltip: 'staff request',
                onPressed: () async {
                  final result = await showConfirmDialog(
                    context,
                    // appRoute,
                    title:
                        // 'Do you want to apply for staffs?'
                        l10n.wouldYouLikeToRegisterAsAStaffMember,
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
                      // await appRoute.pop();
                      await showFluttertoast(
                        l10n.registered,
                        webBgColor: 'amber',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                      );
                      return;
                    }
                    if (context.mounted) {
                      await showTextDialog(
                        context,
                        // appRoute,
                        title: l10n.notification,
                        message: l10n.theCodeIsWrong,
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
  const RegisterProgramElevatedButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.register),
      builder: (context, ref, child) {
        return BaseElevatedButton(onPressed: onPressed, child: child!);
      },
    );
  }
}

class CancelElevatedButton extends HookWidget {
  const CancelElevatedButton({super.key});
  @override
  Widget build(BuildContext context) {
    // final appRoute = useRouter();
    final l10n = useL10n();
    return Consumer(
      child: Text(l10n.cancel),
      builder: (context, ref, child) {
        return BaseElevatedButton(
          onPressed: () => RouterUtils.safePop(context),
          child: child!,
        );
      },
    );
  }
}

class FavoriteProgramIconButton extends HookConsumerWidget {
  const FavoriteProgramIconButton({super.key, required this.programId});
  final String programId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();

    return AsyncValueButtonWidget(
      value: ref.watch(authStateChangesProvider),
      data: (isAuthenticated) {
        if (!isAuthenticated) {
          return const SizedBox.shrink();
        }

        return AsyncValueButtonWidget(
          value: ref.watch(favoriteCheckExistenceProvider(programId)),
          data: (isFavorite) {
            final icon = isFavorite ? Icons.favorite : Icons.favorite_outline;
            void onPressed() {
              if (isFavorite) {
                ref
                    .watch(favoriteViewModelProvider.notifier)
                    .deleteFavorite(programId);
              } else {
                ref
                    .watch(favoriteViewModelProvider.notifier)
                    .addFavorite(Favorite(programId: programId));
              }
            }

            return BaseIconButton(
              icon: Icon(icon),
              tooltip: l10n.favorite,
              onPressed: onPressed,
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
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(addProductButtonStateProvider(program)),
          data: (data) {
            if (data) {
              return BaseIconButton(
                icon: const Icon(Icons.qr_code_scanner),
                tooltip: 'QRCodeScan',
                onPressed: () {
                  // appRoute.push(QRScanRoute(programId: program.id!));
                  // appRoute
                  //     .push(QRCodeScannerRoute(currentEventID: program.id!));
                  QRCodeScannerRoute(currentEventID: program.id!).push(context);
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

class TermIconButton extends HookWidget {
  const TermIconButton({super.key, required this.program});
  final Program program;

  @override
  Widget build(BuildContext context) {
    final l10n = useL10n();
    // final appRoute = useRouter();
    return Consumer(
      builder: (context, ref, child) {
        return AsyncValueButtonWidget(
          value: ref.watch(addProductButtonStateProvider(program)),
          data: (data) {
            // if (data) {
            return BaseIconButton(
              icon: const Icon(Icons.library_books_outlined),
              tooltip: 'Term',
              onPressed: () {
                // appRoute.push(TermsRoute(uid: program.organizerId!));
                TermsRoute(uid: program.organizerId!).push(context);
              },
            );
            // } else {
            //   return Container();
            // }
          },
        );
      },
    );
  }
}
