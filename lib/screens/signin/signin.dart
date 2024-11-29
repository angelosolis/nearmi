import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final dynamic from;
  const SignIn({Key? key, required this.from}) : super(key: key);

  @override
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();

  bool _showPassword = false;
  String? _errorID;
  String? _errorPass;

  @override
  void initState() {
    super.initState();
    _textIDController.text = "";
    _textPassController.text = "";
  }

  @override
  void dispose() {
    _textIDController.dispose();
    _textPassController.dispose();
    _focusID.dispose();
    _focusPass.dispose();
    super.dispose();
  }

  ///On navigate forgot password
  void _forgotPassword() {
    Navigator.pushNamed(context, Routes.forgotPassword);
  }

  ///On navigate sign up
  void _signUp() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.signUp,
    );
    if (result != null && result is List) {
      _textIDController.text = result[0];
      _textPassController.text = result[1];
      final user = await AppBloc.authenticateCubit.onLogin(
        username: _textIDController.text,
        password: _textPassController.text,
      );
      if (!mounted || user == null) return;
      Navigator.pop(context, widget.from);
    }
  }

  ///On login
  void _login() async {
    Utils.hiddenKeyboard(context);
    setState(() {
      _errorID = UtilValidator.validate(_textIDController.text);
      _errorPass = UtilValidator.validate(_textPassController.text);
    });
    if (_errorID == null && _errorPass == null) {
      final user = await AppBloc.authenticateCubit.onLogin(
        username: _textIDController.text,
        password: _textPassController.text,
      );
      if (!mounted || user == null) return;
      Navigator.pop(context, widget.from);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('sign_in'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppTextInput(
                  hintText: Translate.of(context).translate('account'),
                  errorText: _errorID,
                  controller: _textIDController,
                  focusNode: _focusID,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _errorID = UtilValidator.validate(
                        _textIDController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _focusID, _focusPass);
                  },
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('password'),
                  errorText: _errorPass,
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {
                    setState(() {
                      _errorPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    _login();
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Icon(_showPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                  obscureText: !_showPassword,
                  controller: _textPassController,
                  focusNode: _focusPass,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('sign_in'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _login,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppButton(
                      Translate.of(context).translate('forgot_password'),
                      onPressed: _forgotPassword,
                      type: ButtonType.text,
                    ),
                    AppButton(
                      Translate.of(context).translate('sign_up'),
                      onPressed: _signUp,
                      type: ButtonType.text,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
