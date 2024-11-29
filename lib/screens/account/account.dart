import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() {
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On logout
  void _onLogout() async {
    AppBloc.authenticateCubit.onLogout();
  }

  ///On logout
  void _onDeactivate() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('deactivate')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Text(
                Translate.of(context).translate('would_you_like_deactivate'),
                style: Theme.of(context).textTheme.bodyMedium,
              );
            },
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('close'),
              onPressed: () {
                Navigator.pop(context, false);
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('yes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
    if (result == true) {
      AppBloc.authenticateCubit.onDeactivate();
    }
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///On Preview Profile
  void _onProfile(UserModel user) {
    Navigator.pushNamed(context, Routes.profile, arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('account'),
        ),
        actions: [
          AppButton(
            Translate.of(context).translate('sign_out'),
            mainAxisSize: MainAxisSize.max,
            onPressed: _onLogout,
            type: ButtonType.text,
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserModel?>(
          builder: (context, user) {
            if (user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).dividerColor.withAlpha(10),
                          spreadRadius: 4,
                          blurRadius: 4,
                          offset: const Offset(
                            0,
                            2,
                          ),
                        ),
                      ],
                    ),
                    child: AppUserInfo(
                      user: user,
                      type: UserViewType.information,
                      onPressed: () {
                        _onProfile(user);
                      },
                    ),
                  ),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Column(
                      children: <Widget>[
                        AppListTitle(
                          title: Translate.of(context).translate(
                            'edit_profile',
                          ),
                          trailing: RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          onPressed: () {
                            _onNavigate(Routes.editProfile);
                          },
                        ),
                        AppListTitle(
                          title: Translate.of(context).translate(
                            'change_password',
                          ),
                          trailing: RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          onPressed: () {
                            _onNavigate(Routes.changePassword);
                          },
                        ),
                        AppListTitle(
                          title: Translate.of(context).translate(
                            'booking_management',
                          ),
                          trailing: RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          onPressed: () {
                            _onNavigate(Routes.bookingManagement);
                          },
                        ),
                        AppListTitle(
                          title: Translate.of(context).translate('setting'),
                          onPressed: () {
                            _onNavigate(Routes.setting);
                          },
                          trailing: RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                        AppListTitle(
                          title: Translate.of(context).translate('deactivate'),
                          onPressed: _onDeactivate,
                          trailing: RotatedBox(
                            quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                          border: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
