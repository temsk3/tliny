import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';

import '../../settings/hooks/use_media_query.dart';

final logger = Logger();

class MainBodyWidget extends HookWidget {
  const MainBodyWidget({super.key, required this.body, this.width});
  final Widget body;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final appMediaQuery = useMediaQuery();
    // logger.d(appMediaQuery.size.toString());
    // return SafeArea(
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       appMediaQuery.size.width > 1024
    //           ? const CustomDrawer()
    //           : Container(),
    //       Expanded(
    //         child: appMediaQuery.size.width > 1024
    //             ? SizedBox(
    //                 width: 400,
    //                 child: SizedBox(
    //                   width: width,
    //                   child: body,
    //                 ),
    //               )
    //             : Container(
    //                 child: body,
    //               ),
    //       ),
    //     ],
    //   ),
    // );
    return SafeArea(child: body);
  }
}
