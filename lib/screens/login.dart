import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/utils/utils.dart';
import '/screens/screens.dart';
import 'package:web_app/widgets/widgets.dart';
import 'package:web_app/constants.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _emailController = TextEditingController();
  // 2
  final _passwordController = TextEditingController();
  // 3
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Stack(
      children: [
        const BgImageWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                const Spacer(),
                EmailInputWidget(emailController: _emailController),
                const SizedBox(
                  height: 20,
                ),
                PassWordInputWidget(passwordController: _passwordController),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          Map result = await authProvider.signIn(
                              _emailController.text, _passwordController.text);
                          bool success = result['success'];
                          String message = result['message'];
                          print(message);

                          if (!success) {
                            setState(() {
                              loading = false;
                            });

                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          "Entrer",
                          style: kbutton,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (loading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
