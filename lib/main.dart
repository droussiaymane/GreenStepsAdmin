import 'package:web_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';


void main() async{
  
  
  WidgetsFlutterBinding.ensureInitialized();
  await initialization;
  runApp(const MyApp());
}

//the app to be runned (the big materialApp)
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HistoriqueProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider.init(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UtilisateursProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CompetitionProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: lightTheme(context),
        debugShowCheckedModeBanner: false,
        title: 'Green Steps',
        home: const MainScreen(),
      ),
    );
  }
}

class AppStateController extends StatelessWidget {
  const AppStateController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.uninitialized:
        return const Center(child: CircularProgressIndicator());

      // case Status.authenticating:
      case Status.unauthenticated:
        return const LogIn();
      case Status.authenticated:
        return const MainScreen();
      default:
        return const Center(child: CircularProgressIndicator()) ;
    }
  }
}
