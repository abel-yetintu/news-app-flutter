import 'package:echo/core/dependecy_injection.dart';
import 'package:echo/core/routing/route_generator.dart';
import 'package:echo/features/articles/presentation/bloc/category_bloc.dart';
import 'package:echo/features/articles/presentation/bloc/top_headlines_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load();
  await initSL();
  runApp(const Echo());
}

class Echo extends StatelessWidget {
  const Echo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => sl<TopHeadlinesBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 56, 149, 211),
          ),
        ),
        navigatorKey: sl<GlobalKey<NavigatorState>>(),
        onGenerateRoute: RouteGenerator.onGenerateRoure,
        initialRoute: '/',
      ),
    );
  }
}
