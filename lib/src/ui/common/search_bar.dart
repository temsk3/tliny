import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  void _submission(text) {
    setState(() {
      _controller.clear();
      if (kDebugMode) {
        logger.d(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: SizedBox(
        height: 40,
        child: Container(
          width: 340,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: 340,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search Text',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon:
                      // IconButton(
                      //   icon: const Icon(Icons.clear),
                      //   onPressed: _controller.clear,
                      // ),
                      TextButton(
                    onPressed: _controller.clear,
                    child: const Icon(Icons.clear),
                  ),
                  contentPadding: const EdgeInsets.only(left: 8),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isDense: true,
                ),
                onSubmitted: _submission,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
