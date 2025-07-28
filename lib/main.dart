import 'package:crypto_fake/bloc/login/login_bloc.dart';
import 'package:crypto_fake/bloc/presentation/chart/chandle_data_bloc.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_event.dart';
import 'package:crypto_fake/bloc/presentation/chart/chart_state.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_bloc.dart';
import 'package:crypto_fake/bloc/presentation/datacust/datacust_event.dart';
import 'package:crypto_fake/bloc/theme/theme_bloc.dart';
import 'package:crypto_fake/bloc/theme/theme_state.dart';
import 'package:crypto_fake/data/services/AuthService.dart';
import 'package:crypto_fake/routes/Routes.dart';
import 'package:crypto_fake/view/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeBloc()),
          BlocProvider(
            create: (context) => DataCustBloc(context.read<AuthService>())
              ..add(LoadDataCust()),
          ),
          BlocProvider(
            create: (_) => ChartBloc()..add(LoadChartData()),
          ),
          BlocProvider(
            create: (context) => LoginBloc(authService: context.read<AuthService>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: themeState.themeMode,
              initialRoute: Routes.login,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}



