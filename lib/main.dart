import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './../services/serviceconfig.dart';
import './../di/servicelocator.dart';
import './../ui/homescreen/homeviewmodel.dart';
import './../ui/login/loginscreen.dart';
import './../ui/login/loginviewmodel.dart';
import './../ui/signup/signupviewmodel.dart';
import './../utils/navigationservice.dart';
import './../utils/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initialize();
  await initializeService();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _navHandler = getIT<NavigationHandler>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
      ),
      navigatorKey: _navHandler.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        builder: (context, child) => const LoginScreen(),
      ),
    );
  }
}
