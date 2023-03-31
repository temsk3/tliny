import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../data/model/user_model.dart';
import '../../settings/hooks/use_l10n.dart';
import '../../settings/hooks/use_media_query.dart';
import '../../settings/hooks/use_router.dart';
import '../../settings/theme/app_theme.dart';
import '../../ui/common/main_body.dart';
import '../../utils/validation_utils.dart';
import '../common/asyncvalue_widget.dart';
import 'user_view_model.dart';

final logger = Logger();

@RoutePage()
class UserEditPage extends HookConsumerWidget {
  const UserEditPage({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final l10n = useL10n();
    final appRoute = useRouter();
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
          appBar: AppBar(
            title: const Text('Profile'), automaticallyImplyLeading: false,
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
                        const CircleAvatar(
                          radius: 75,
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
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
                          onChanged: (value) {
                            // _name.text = value.toString();
                          },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
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
                          onChanged: (value) {
                            // _name.text = value.toString();
                          },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
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
                          onChanged: (value) {
                            // _name.text = value.toString();
                          },
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
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
                          onChanged: (value) {
                            // _name.text = value.toString();
                          },
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: appRoute.pop,
                              child: Text(l10n.cancel),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final data = User(
                                  id: uid,
                                  displayName: displayName.text,
                                  name: name.text,
                                  email: email.text,
                                  phoneNumber: phoneNumber.text,
                                );
                                viewModel.updateUser(data);
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
