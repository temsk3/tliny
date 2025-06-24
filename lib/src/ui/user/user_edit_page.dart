import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tliny/src/ui/image/image_view_model.dart';

import '../../data/model/user_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../ui/common/main_body.dart';
import '../../utils/logger.dart';
import '../../utils/validation_utils.dart';
import '../common/asyncvalue_widget.dart';
import '../image/image_screen.dart';
import 'user_view_model.dart';

// final logger = Logger();

// @RoutePage()
class UserEditPage extends HookConsumerWidget {
  const UserEditPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    // final appRoute = useRouter();
    final appMediaQuery = useMediaQuery();
    // final state = ref.watch(programStateProvider);
    // final authState = ref.watch(authViewModelProvider);
    // final uid = authState?.uid;
    final state = ref.watch(userViewModelProvider);
    final viewModel = ref.watch(userViewModelProvider.notifier);

    final form = GlobalKey<FormState>();

    final email = useTextEditingController();
    final displayName = useTextEditingController();
    final name = useTextEditingController();
    final phoneNumber = useTextEditingController();
    return AsyncValueWidget(
      value: state,
      data: (data) {
        logger.d(data);

        email.text = data.email == null ? '' : data.email!;
        displayName.text = data.displayName == null ? '' : data.displayName!;
        name.text = data.name == null ? '' : data.name!;
        phoneNumber.text = data.phoneNumber == null ? '' : data.phoneNumber!;
        // final user = User(
        //   displayName: displayName.text,
        //   name: name.text,
        //   email: email.text,
        //   phoneNumber: phoneNumber.text,
        // );
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(l10n.profile), automaticallyImplyLeading: false,
            // leading: const AutoLeadingButton(),
          ),
          body: MainBodyWidget(
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    key: form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditCircleAvatar(data.photoUrl),
                        const SizedBox(height: 40),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: email,
                          decoration: InputDecoration(labelText: l10n.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterSomeText;
                            }
                            ValidationUtils.validateEmail(value);
                            return null;
                          },
                          onSaved: (value) {
                            email.text = value.toString();
                          },
                          // onChanged: (value) {
                          //   // _name.text = value.toString();
                          // },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: displayName,
                          decoration:
                              InputDecoration(labelText: l10n.displayName),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterSomeText;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            displayName.text = value.toString();
                          },
                          // onChanged: (value) {
                          //   // _name.text = value.toString();
                          // },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: name,
                          decoration: InputDecoration(labelText: l10n.name),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterSomeText;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            name.text = value.toString();
                          },
                          // onChanged: (value) {
                          //   // _name.text = value.toString();
                          // },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: phoneNumber,
                          decoration: InputDecoration(labelText: l10n.phone),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterSomeText;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phoneNumber.text = value.toString();
                          },
                          // onChanged: (value) {
                          //   // _name.text = value.toString();
                          // },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => context.pop(),
                              // appRoute.navigate(AppRoutes.mainPage),
                              // appRoute.replaceAll(
                              //   [const HomeRoute(), const UserRoute()],
                              // ),
                              child: Text(l10n.cancel),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final User data;

                                final photo =
                                    ref.watch(tempImageViewModelProvider).value;
                                if (photo != null) {
                                  final url =
                                      await viewModel.updatePhoto(uid, photo);
                                  data = User(
                                    id: uid,
                                    displayName: displayName.text,
                                    name: name.text,
                                    email: email.text,
                                    phoneNumber: phoneNumber.text,
                                    photoUrl: url,
                                  );
                                } else {
                                  data = User(
                                    id: uid,
                                    displayName: displayName.text,
                                    name: name.text,
                                    email: email.text,
                                    phoneNumber: phoneNumber.text,
                                  );
                                }

                                await viewModel.updateUser(data);
                                // await appRoute.navigate(const UserRoute());
                                context.pop();
                              },
                              child: Text(l10n.update),
                            ),
                          ],
                        ),
                      ],
                    ),
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
