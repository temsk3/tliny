import 'package:flutter/material.dart';

// final RegExp _styledPattern = RegExp(r'{(\\[a-z]+\d* )*?(.*?)}', dotAll: true);
// final RegExp _listPattern =
//     RegExp(r'\\pard\\tx(\d+).*?\\li(\d+)(.*?)\\par', dotAll: true);

// List<Map<String, dynamic>> extractSpans(String rtfContent) {
//   final spans = <Map<String, dynamic>>[];

//   // Match the patterns and extract styles and content
//   final matches = _styledPattern.allMatches(rtfContent);

//   for (final match in matches) {
//     final properties = match.group(1) ?? '';
//     var text = match.group(2) ?? '';

//     final style = <String, dynamic>{
//       'bold': properties.contains('\\b '),
//       'italic': properties.contains('\\i '),
//       'underline': properties.contains('\\ul '),
//       'fontsize': 12,
//       'color': '1',
//       'list': false,
//       'ordered_list': properties.contains('\\fi-'),
//       'indent': 0,
//       'tab': text.contains('\\tab')
//     };

//     if (properties.contains('\\fs')) {
//       final fsMatch = RegExp(r'\\fs(\d+)').firstMatch(properties);
//       if (fsMatch != null) {
//         style['fontsize'] = int.parse(fsMatch.group(1).toString());
//       }
//     }

//     if (properties.contains('\\cf')) {
//       final cfMatch = RegExp(r'\\cf(\d+)').firstMatch(properties);
//       if (cfMatch != null) {
//         style['color'] = cfMatch.group(1);
//       }
//     }

//     final listMatch = _listPattern.firstMatch(text);
//     if (listMatch != null) {
//       style['list'] = true;
//       style['indent'] = int.parse(listMatch.group(2).toString()) ~/
//           360; // Convert twips to approximate number of spaces
//     }

//     // Clean up plain texts
//     text = text.replaceAllMapped(RegExp(r'\\[^ ]+ ?'), (match) => '');
//     text = text.replaceAllMapped(RegExp(r'{.*?}'), (match) => '');
//     text = text.replaceAll('\\tab', '\t');

//     spans.add({'text': text.trim(), 'style': style});
//   }

//   return spans;
// }

// AlertDialog createRTFDialog(String rtfContent) {
//   final spans = extractSpans(rtfContent);

//   return AlertDialog(
//     content: SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: spans.map((span) {
//           final style = TextStyle(
//             fontWeight: span['style']['bold'] as bool
//                 ? FontWeight.bold
//                 : FontWeight.normal,
//             fontStyle: span['style']['italic'] as bool
//                 ? FontStyle.italic
//                 : FontStyle.normal,
//             decoration: span['style']['underline'] as bool
//                 ? TextDecoration.underline
//                 : TextDecoration.none,
//             fontSize: span['style']['fontsize'] as double,
//             color: Colors.black, // Placeholder color
//           );

//           if (span['style']['list'] as bool) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 left: (span['style']['indent'] as double) * 10.0,
//               ),
//               child: Row(
//                 children: [
//                   Text('•', style: style),
//                   const SizedBox(width: 8),
//                   Expanded(child: Text(span['text'] as String, style: style)),
//                 ],
//               ),
//             );
//           } else if (span['style']['ordered_list'] as bool) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 left: (span['style']['indent'] as double) * 10.0,
//               ),
//               child: Row(
//                 children: [
//                   Text('1.', style: style), // Placeholder list number
//                   const SizedBox(width: 8),
//                   Expanded(child: Text(span['text'] as String, style: style)),
//                 ],
//               ),
//             );
//           } else if (span['style']['tab'] as bool) {
//             return Text(
//               (span['text'] as String).replaceAll('\t', '    '),
//               style: style,
//             );
//           } else {
//             return Text(span['text'] as String, style: style);
//           }
//         }).toList(),
//       ),
//     ),
//   );
// }

AlertDialog parseRtfToDart(String rtf) {
  var isBold = false;
  var isItalic = false;
  var isUnderline = false;
  var isList = false;
  var isNumberedList = false;
  var fontSize = '';
  var fontColor = '';
  var listItems = <String>[];
  var parsedText = StringBuffer();

  for (var i = 0; i < rtf.length; i++) {
    // Check for bold
    if (rtf.substring(i).startsWith('\\b ')) {
      isBold = true;
      i += 2;
    } else if (rtf.substring(i).startsWith('\\b0')) {
      isBold = false;
      i += 2;
    }

    // Check for italic
    if (rtf.substring(i).startsWith('\\i ')) {
      isItalic = true;
      i += 2;
    } else if (rtf.substring(i).startsWith('\\i0')) {
      isItalic = false;
      i += 2;
    }

    // Check for underline
    if (rtf.substring(i).startsWith('\\ul ')) {
      isUnderline = true;
      i += 3;
    } else if (rtf.substring(i).startsWith('\\ul0')) {
      isUnderline = false;
      i += 3;
    }

    // Check for font size
    if (rtf.substring(i).startsWith('\\fs')) {
      var j = i + 3;
      while (rtf[j].isNotEmpty && rtf[j] != ' ') {
        fontSize += rtf[j];
        j++;
      }
      i = j;
    }

    // Check for font color
    if (rtf.substring(i).startsWith('\\cf')) {
      fontColor = rtf.substring(i + 3, i + 4);
      i += 3;
    }

    // Check for bullet list
    if (rtf.substring(i).startsWith('\\bullet')) {
      isList = true;
      i += 7;
    } else if (rtf.substring(i).startsWith('\\li') &&
        !rtf.substring(i).startsWith('\\li0')) {
      isNumberedList = true;
      i += 2;
    } else if (rtf.substring(i).startsWith('\\li0')) {
      isList = false;
      isNumberedList = false;
      i += 3;
    }

    if (isList || isNumberedList) {
      final listItem = StringBuffer();
      while (i < rtf.length && rtf[i] != '\\') {
        listItem.write(rtf[i]);
        i++;
      }
      listItems.add(listItem.toString());
      continue;
    }

    // Append parsed text
    parsedText.write(rtf[i]);
  }

  // Convert parsed text to Dart AlertDialog code
  var spans = <TextSpan>[
    TextSpan(
      text: parsedText.toString(),
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontSize: double.tryParse(fontSize) ?? 14.0,
        color: _getColorFromIndex(int.tryParse(fontColor) ?? 1),
      ),
    ),
    ..._generateListSpans(listItems, isList, isNumberedList)
  ];

  return AlertDialog(
    content: RichText(
      text: TextSpan(
        children: spans,
      ),
    ),
  );
}

List<TextSpan> _generateListSpans(
  List<String> items,
  bool isBulletList,
  bool isNumberedList,
) {
  if (isBulletList) {
    return items.map((item) => TextSpan(text: '• $item\n')).toList();
  } else if (isNumberedList) {
    return items
        .asMap()
        .entries
        .map((entry) => TextSpan(text: '${entry.key + 1}. ${entry.value}\n'))
        .toList();
  }
  return [];
}

Color _getColorFromIndex(int index) {
  // Placeholder function. You'd need to map RTF color index to actual Dart Color objects.
  switch (index) {
    case 1:
      return Colors.black;
    // Add more cases for different color indices
    default:
      return Colors.black;
  }
}
