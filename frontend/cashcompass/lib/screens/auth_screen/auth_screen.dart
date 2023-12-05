import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _passwordIsHidden = true;
  bool _repeatPasswordIsHidden = true;
  bool _isLogin = true;
  bool _emailIsInvalid = false;
  bool _passwordIsInvalid = false;
  bool _repeatPasswordIsInvalid = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar(
      //   middle: Text('Login!'),
      // ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(16.0),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: CupertinoColors.black,
          //     width: 1.0,
          //     style: BorderStyle.solid,
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isLogin ? "Ahoi!" : "Get on board!",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CupertinoTextField(
                  placeholder: "email",
                  controller: _emailController,
                  autocorrect: false,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Visibility(
                visible: _emailIsInvalid,
                child: const Row(
                  children: [
                    Text(
                      " Invalid email address!",
                      style: TextStyle(
                        color: CupertinoColors.systemRed,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CupertinoTextField(
                  placeholder: "password",
                  autocorrect: false,
                  controller: _passwordController,
                  obscureText: _passwordIsHidden,
                  suffix: GestureDetector(
                    onTap: _togglePasswordView,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                          _passwordIsHidden
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill,
                          size: 16.0),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _passwordIsInvalid,
                child: const Row(
                  children: [
                    Text(
                      " Invalid password!",
                      style: TextStyle(
                        color: CupertinoColors.systemRed,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (!_isLogin) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CupertinoTextField(
                    placeholder: "repeat password",
                    autocorrect: false,
                    controller: _repeatPasswordController,
                    obscureText: _repeatPasswordIsHidden,
                    suffix: GestureDetector(
                      onTap: _toggleRepeatPasswordView,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                            _repeatPasswordIsHidden
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            size: 16.0),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _repeatPasswordIsInvalid,
                  child: const Row(
                    children: [
                      Text(
                        " Password falsly repeated!",
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _isLogin
                            ? "Not yet registered? "
                            : "Already have an account? ",
                        style: const TextStyle(color: CupertinoColors.black),
                      ),
                      TextSpan(
                          text: _isLogin ? "Create an account!" : "Log in!",
                          style: const TextStyle(
                              color: CupertinoColors.activeBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _togglePageMode()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton.filled(
                  onPressed: () => _handleAuthentication(),
                  child: Text(_isLogin ? "LOGIN" : "SIGN UP"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _passwordIsHidden = !_passwordIsHidden;
    });
  }

  void _togglePageMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _toggleRepeatPasswordView() {
    setState(() {
      _repeatPasswordIsHidden = !_repeatPasswordIsHidden;
    });
  }

  void _handleAuthentication() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String repeatePassword = _repeatPasswordController.text;

    setState(() {
      _emailIsInvalid = false;
      _passwordIsInvalid = false;
      _repeatPasswordIsInvalid = false;
    });

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      setState(() {
        _emailIsInvalid = true;
      });
      return;
    }
    if (password.isEmpty) {
      setState(() {
        _passwordIsInvalid = true;
      });
      return;
    }
    if (!_isLogin && !(password == repeatePassword)) {
      setState(() {
        _repeatPasswordIsInvalid = true;
      });
      return;
    }
  }
}
