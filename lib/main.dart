import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'screens/home_screen.dart';
import 'utils/constants.dart';
import 'utils/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) async {
    await initApp();
    FlutterError.onError = (errorDetails) {};

    PlatformDispatcher.instance.onError = (error, stack) {
      return true;
    };

    runApp(MyApp());
  });
}

Future<void> initApp() async {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  await dotenv.load(fileName: Environment.fileName);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: ThemeData.dark().copyWith(
            platform: TargetPlatform.iOS,
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: kPrimaryColor,
          ),
          home: HomeScreen(
            key: kHomeScreenKey,
          ),
        );
      },
    );
  }
}
