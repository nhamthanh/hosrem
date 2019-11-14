import 'package:bloc/bloc.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/common/app_assets.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hosrem_app/auth/auth_provider.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/config/api_config.dart';
import 'package:hosrem_app/db/app_database.dart';
import 'package:hosrem_app/network/api_provider.dart';
import 'package:hosrem_app/notification/fcm_configuration.dart';
import 'package:hosrem_app/splash/splash.dart';

import 'app_bloc_delegate.dart';
import 'app_context.dart';
import 'app_routes.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_state.dart';

/// Main stateful widget of the application.
class App extends StatefulWidget {
  const App({Key key, @required this.apiConfig}) : super(key: key);

  final ApiConfig apiConfig;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();

    BlocSupervisor.delegate = AppBlocDelegate();

    final Router router = Router();
    AppRoutes.configureRoutes(router);

    final ApiProvider apiProvider = ApiProvider(widget.apiConfig.apiBaseUrl);
    _appBloc = AppBloc(AppContext(
      router: router,
      appDatabase: AppDatabase(),
      apiConfig: widget.apiConfig,
      apiProvider: apiProvider)
    );

    timeago.setLocaleMessages('vi', timeago.ViMessages());
    _configureFcm(apiProvider);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      builder: (BuildContext context) => _appBloc,
      child: BlocBuilder<AppBloc, AppState>(
        bloc: _appBloc,
        builder: (BuildContext context, AppState state) {
          // ignore: always_specify_types
          final data = EasyLocalizationProvider.of(context).data;
          data.changeLocale(const Locale('en', 'US'));
          return EasyLocalizationProvider(
            data: data,
            child: MaterialApp(
              title: 'Hosrem Application',
              theme: _buildThemeData(state),
              localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                //app-specific localization
                EasylocaLizationDelegate(
                  locale: data.locale,
                  path: AppAssets.languagesFolder
                )
              ],
              supportedLocales: const <Locale>[Locale('en', 'US'), Locale('vi', 'VN')],
              home: AuthProvider(
                apiProvider: _appBloc.appContext.apiProvider,
                handleUnauthorized: _handleUnauthorized,
                child: Splash()
              )
            )
          );
        }
      )
    );
  }

  void _handleUnauthorized(BuildContext context) {
    try {
      _appBloc.appContext.router.navigateTo(context, AppRoutes.loginRoute, transition: TransitionType.fadeIn);
    } catch(error) {
      print(error);
    }
  }

  ThemeData _buildThemeData(AppState state) {
    if (state == AppState.light) {
      return ThemeData(
        brightness: Brightness.light,
        accentColor: AppColors.lightAccentColor,
        primaryColor: AppColors.lightPrimaryColor,
        primaryTextTheme: const TextTheme(
          title: TextStyle(
            color: Colors.white
          )
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        fontFamily: 'Muli'
      );
    }

    return ThemeData(
      brightness: Brightness.dark,
      accentColor: AppColors.darkAccentColor,
      primaryColor: AppColors.darkPrimaryColor,
      fontFamily: 'Muli'
    );
  }

  void _configureFcm(ApiProvider apiProvider) {
    final FcmConfiguration fcmConfiguration = FcmConfiguration(apiProvider);
    fcmConfiguration.initFcm(context);
  }
}
