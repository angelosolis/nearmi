import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class FontSetting extends StatefulWidget {
  const FontSetting({Key? key}) : super(key: key);

  @override
  State<FontSetting> createState() {
    return _FontSettingState();
  }
}

class _FontSettingState extends State<FontSetting> {
  String? _currentFont;
  double _currentScale = 100;

  @override
  void initState() {
    super.initState();
    ApplicationState state = AppBloc.applicationCubit.state;
    if (state is ApplicationStateSuccess) {
      _currentFont = state.theme.font;
      _currentScale = (state.theme.textScaleFactor ?? 1) * 100;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change Font
  void _onChange() {
    AppBloc.applicationCubit.onChangeTheme(
      font: _currentFont,
      textScaleFactor: _currentScale / 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('font'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('apply'),
            onPressed: _onChange,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = AppTheme.fontSupport[index];
                  if (item == _currentFont) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }
                  return AppListTitle(
                    title: item,
                    trailing: trailing,
                    border: item != AppTheme.fontSupport.last,
                    onPressed: () {
                      setState(() {
                        _currentFont = item;
                      });
                    },
                  );
                },
                itemCount: AppTheme.fontSupport.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.sort_by_alpha_outlined,
                    size: 20,
                  ),
                  Expanded(
                    child: Slider(
                      value: _currentScale,
                      max: 140,
                      min: 80,
                      divisions: 10,
                      label: _currentScale.toString(),
                      onChanged: (value) {
                        setState(() {
                          _currentScale = value;
                        });
                      },
                    ),
                  ),
                  const Icon(
                    Icons.sort_by_alpha_outlined,
                    size: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
