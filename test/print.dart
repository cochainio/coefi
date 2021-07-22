final _pattern = RegExp('.{1,800}'); // 800 is the size of each chunk

/// [printWrapped] avoids the issue https://github.com/flutter/flutter/issues/22665.
void printWrapped(String text) {
  // ignore: avoid_print
  _pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
