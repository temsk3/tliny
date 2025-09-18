// import 'package:auto_route/annotations.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:intl/intl.dart';

// import '../../data/model/staff_model.dart';
// import '../../settings/hooks/use_l10n.dart';
// import '../../settings/hooks/use_media_query.dart';
// import '../../settings/hooks/use_router.dart';
// import '../../settings/theme/app_theme.dart';
// import 'staff_view_model.dart';

// @RoutePage()
// class StaffDetailsPage extends HookConsumerWidget {
//   const StaffDetailsPage({
//     super.key,
//     required this.programId,
//     required this.staff,
//   });
//   final String programId;
//   final Staff staff;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(appThemeProvider);
//     // final l10n = useL10n();
//     final appRoute = useRouter();
//     final appMediaQuery = useMediaQuery();
//     // final state = ref.watch(staffViewModelProvider(programId));
//     final viewModel = ref.watch(staffViewModelProvider(programId).notifier);

//     final dateFormatter =
//         DateFormat.yMMMEd(Localizations.localeOf(context).toString());

//     // final bazaar = bazaarEvent;
//     // final supported = ref.watch(supporterListStreamProvider(bazaar.id));
//     // final owner = useState<bool>(false);
//     // final supporter = useState<bool>(false);
//     // final authState = ref.watch(authStateProvider);

//     return const Scaffold();
//   }
// }
