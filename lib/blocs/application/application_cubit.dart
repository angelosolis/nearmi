import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/repository.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationStateLoading());

  ///On Setup Application
  void onSetup() async {
    ///Get old Theme & Font & Language & Dark Mode & Domain
    await Preferences.setPreferences();

    final oldTheme = Preferences.getString(Preferences.theme);
    final oldFont = Preferences.getString(Preferences.font);
    final oldLanguage = Preferences.getString(Preferences.language);
    final oldDarkOption = Preferences.getString(Preferences.darkOption);
    final oldDomain = Preferences.getString(Preferences.domain);
    final oldTextScale = Preferences.getDouble(Preferences.textScaleFactor);
    final oldSetting = Preferences.getString(Preferences.setting);

    DarkOption darkOption = AppTheme.darkThemeOption;
    String font = AppTheme.defaultFont;
    ThemeModel theme = AppTheme.defaultTheme;
    Locale language = AppLanguage.defaultLanguage;

    ///Setup domain
    if (oldDomain != null) {
      Application.domain = oldDomain;
    }

    ///Setup Language
    if (oldLanguage != null) {
      language = Locale(oldLanguage);
    }

    ///Find font support available [Dart null safety issue]
    try {
      font = AppTheme.fontSupport.firstWhere((item) {
        return item == oldFont;
      });
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }

    ///Setup theme
    if (oldTheme != null) {
      theme = ThemeModel.fromJson(jsonDecode(oldTheme));
    }

    ///check old dark option
    if (oldDarkOption != null) {
      switch (oldDarkOption) {
        case 'off':
          darkOption = DarkOption.alwaysOff;
          break;
        case 'on':
          darkOption = DarkOption.alwaysOn;
          break;
        default:
          darkOption = DarkOption.dynamic;
      }
    }

    ///Setup application & setting
    final results = await Future.wait([
      PackageInfo.fromPlatform(),
      Utils.getDeviceInfo(),
      Firebase.initializeApp(),
    ]);

    Application.packageInfo = results[0] as PackageInfo?;
    Application.device = results[1] as DeviceModel?;

    if (oldSetting == null) {
      final setting = await ListRepository.loadSetting();
      Application.setting = setting;
    } else {
      Application.setting = SettingModel.fromJson(jsonDecode(oldSetting));
      ListRepository.loadSetting().then((setting) {
        Application.setting = setting;
      });
    }

    ///Authentication begin check
    AppBloc.authenticateCubit.onCheck();

    ///Setup Theme & Font with dark Option
    ThemeState appTheme = await _saveTheme(
      theme: theme,
      font: font,
      darkOption: darkOption,
      textScaleFactor: oldTextScale,
    );

    emit(ApplicationStateSuccess(
      language: language,
      theme: appTheme,
    ));
  }

  ///On Change Theme
  void onChangeTheme({
    ThemeModel? theme,
    String? font,
    DarkOption? darkOption,
    double? textScaleFactor,
  }) async {
    if (state is ApplicationStateSuccess) {
      ApplicationStateSuccess current = state as ApplicationStateSuccess;
      theme ??= current.theme.theme;
      font ??= current.theme.font;
      darkOption ??= current.theme.darkOption;
      textScaleFactor ??= current.theme.textScaleFactor ?? 1.0;

      ThemeState appTheme = await _saveTheme(
        theme: theme,
        font: font,
        darkOption: darkOption,
        textScaleFactor: textScaleFactor,
      );

      emit(ApplicationStateSuccess(
        language: current.language,
        theme: appTheme,
      ));
    }
  }

  ///On Change Language
  void onChangeLanguage(Locale locale) {
    if (state is ApplicationStateSuccess) {
      ApplicationStateSuccess current = state as ApplicationStateSuccess;

      ///Preference save
      Preferences.setString(
        Preferences.language,
        locale.languageCode,
      );
      emit(ApplicationStateSuccess(
        language: locale,
        theme: current.theme,
      ));
    }
  }

  ///On Change Domain
  void onChangeDomain(String domain) async {
    final isDomain = Uri.tryParse(domain);
    if (isDomain != null) {
      emit(ApplicationStateLoading());
      AppBloc.userCubit.onDeleteUser();
      Api.httpManager.changeDomain(domain);
      await Preferences.setString(Preferences.domain, domain);
      await Preferences.remove(Preferences.setting);
      onSetup();
    } else {
      AppBloc.messageBloc.add(MessageEvent(message: "domain_not_correct"));
    }
  }

  Future<ThemeState> _saveTheme({
    required ThemeModel theme,
    required String font,
    required DarkOption darkOption,
    double? textScaleFactor,
  }) async {
    ThemeState themeState = ThemeState.fromDefault();

    ///Dark mode option
    switch (darkOption) {
      case DarkOption.dynamic:
        Preferences.setString(Preferences.darkOption, 'dynamic');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
      case DarkOption.alwaysOn:
        Preferences.setString(Preferences.darkOption, 'on');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.dark,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
      case DarkOption.alwaysOff:
        Preferences.setString(Preferences.darkOption, 'off');
        themeState = ThemeState(
          theme: theme,
          lightTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          darkTheme: AppTheme.getTheme(
            theme: theme,
            brightness: Brightness.light,
            font: font,
          ),
          font: font,
          darkOption: darkOption,
          textScaleFactor: textScaleFactor,
        );
        break;
    }

    ///Theme
    Preferences.setString(
      Preferences.theme,
      jsonEncode(themeState.theme.toJson()),
    );

    ///Font
    Preferences.setString(Preferences.font, themeState.font);

    ///Text Scale
    if (themeState.textScaleFactor != null) {
      Preferences.setDouble(
        Preferences.textScaleFactor,
        themeState.textScaleFactor!,
      );
    }

    return themeState;
  }
}
