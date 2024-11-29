import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:listar_flutter_pro/app_container.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/screens/screen.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<ApplicationCubit, ApplicationState>(
        builder: (context, application) {
          Widget container = const SplashScreen();
          Locale language = AppLanguage.defaultLanguage;
          ThemeState theme = ThemeState.fromDefault();
          if (application is ApplicationStateSuccess) {
            theme = application.theme;
            language = application.language;
            container = const AppContainer();
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            onGenerateRoute: Routes.generateRoute,
            locale: language,
            localizationsDelegates: const [
              Translate.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLanguage.supportLanguage,
            home: Scaffold(
              body: BlocListener<MessageBloc, MessageState?>(
                listener: (context, message) {
                  if (message != null) {
                    final snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: message.duration,
                      content: Row(
                        children: [
                          message.icon,
                          Expanded(
                            child: Text(
                              Translate.of(context).translate(message.value),
                            ),
                          ),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: container,
              ),
            ),
            builder: (context, child) {
              final data = MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(theme.textScaleFactor ?? 1.0),
              );
              return MediaQuery(
                data: data,
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
