import 'package:devlog/bootstrap.dart';
import 'package:flutter/widgets.dart';
import 'package:local_storage_logs_api/local_storage_logs_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final plugin = await SharedPreferences.getInstance();
  final logApi = LocalStorageLogsApi(plugin: plugin);
  bootstrap(logsAPi: logApi);

}
