import 'package:drift/drift.dart';

/// Web stub: native sqlite is not available on the web. This stub will throw
/// if invoked — the app should use a web-compatible repository instead.
LazyDatabase openConnection() {
  throw UnsupportedError('Native database not supported on the web.');
}