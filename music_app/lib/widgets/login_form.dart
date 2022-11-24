import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:music_app/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var isLogin = true;
  final _formKey = GlobalKey<FormState>();
  var _userUsername = "";
  var _userName = "";
  var _userEmail = "";
  var _userPassword = "";
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });

    try {
      print(_userUsername + "/" + _userPassword);
      if (isLogin) {
        await Provider.of<Auth>(context, listen: false)
            .login(_userUsername, _userPassword);
      } else {
        await Provider.of<Auth>(context, listen: false).signup(
            _userUsername, _userName, _userPassword, _userEmail, context);
      }
    } catch (err) {
      _showErrorDialog("Check your username and password!");
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void changeState() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.network(
                  'https://p.kindpng.com/picc/s/21-210072_man-wearing-headphones-silhouette-hd-png-download.png',
                  height: 184,
                ),
                TextFormField(
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userUsername = value!;
                  },
                  decoration: InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.47,
                ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('name'),
                    validator: isLogin
                        ? null
                        : (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                    onSaved: (value) {
                      _userName = value!;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                if (!isLogin)
                  SizedBox(
                    height: 35.47,
                  ),
                if (!isLogin)
                  TextFormField(
                    key: ValueKey('email'),
                    validator: isLogin
                        ? null
                        : (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                if (!isLogin)
                  SizedBox(
                    height: 35.47,
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Your password have to be at least 6 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.47,
                ),
                if (!isLogin)
                  TextFormField(
                    enabled: !isLogin,
                    key: ValueKey('repassword'),
                    validator: isLogin
                        ? null
                        : (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match.';
                            }
                            return null;
                          },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Comfirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                if (!isLogin)
                  SizedBox(
                    height: 35.47,
                  ),
                isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 59,
                        width: 311.4,
                        child: ElevatedButton(
                          onPressed: _submit,
                          child: Text(
                            isLogin ? 'Login' : 'Create',
                            style: TextStyle(fontSize: 16, letterSpacing: 6),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            elevation: 0,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                if (isLogin)
                  Padding(padding: EdgeInsets.only(top: 20), child: Text('or')),
                FlatButton(
                    onPressed: changeState,
                    child: Text(isLogin ? 'Create a new account' : 'Login')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
