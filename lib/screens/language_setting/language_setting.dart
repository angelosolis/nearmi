import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  State<LanguageSetting> createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {
  final _textLanguageController = TextEditingController();

  Locale? _languageSelected;
  List<Locale> _listLanguage = AppLanguage.supportLanguage;

  @override
  void initState() {
    super.initState();
    ApplicationState state = AppBloc.applicationCubit.state;
    if (state is ApplicationStateSuccess) {
      _languageSelected = state.language;
    }
  }

  @override
  void dispose() {
    _textLanguageController.dispose();
    super.dispose();
  }

  ///On filter language
  void _onFilter(String text) {
    if (text.isEmpty) {
      setState(() {
        _listLanguage = AppLanguage.supportLanguage;
      });
      return;
    }
    setState(() {
      _listLanguage = _listLanguage.where(((item) {
        return AppLanguage.getGlobalLanguageName(item.languageCode)
            .toUpperCase()
            .contains(text.toUpperCase());
      })).toList();
    });
  }

  ///On change language
  void _changeLanguage() async {
    Utils.hiddenKeyboard(context);
    AppBloc.applicationCubit.onChangeLanguage(_languageSelected!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_language'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextInput(
                hintText: Translate.of(context).translate('search'),
                controller: _textLanguageController,
                onChanged: _onFilter,
                onSubmitted: _onFilter,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = _listLanguage[index];
                  if (item == _languageSelected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }
                  return AppListTitle(
                    title: AppLanguage.getGlobalLanguageName(
                      item.languageCode,
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        _languageSelected = item;
                      });
                    },
                    border: index != _listLanguage.length - 1,
                  );
                },
                itemCount: _listLanguage.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _changeLanguage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
