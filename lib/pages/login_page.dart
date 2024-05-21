import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:note/model/auth_model.dart';
import 'package:note/widgets/my_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController inEmailTextController = TextEditingController();
  TextEditingController inPassTextController = TextEditingController();

  TextEditingController upEmailTextController = TextEditingController();
  TextEditingController upPassTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();

  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 229, 229),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.fromLTRB(25, 75, 25, 150),
          color: const Color.fromARGB(255, 229, 229, 229),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 50),
          child: Column(
            children: [
              _isSignIn
                  ? Column(
                      children: [
                        const Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        inputTextWidget(
                            "email", inEmailTextController),
                        inputTextWidget(
                            "password", inPassTextController),
                        forgotPassword(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 24, 0, 16),
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      await AuthModel().signIn(
                                          context,
                                          inEmailTextController.text.trim(),
                                          inPassTextController.text.trim(),
                                          );
                                    },
                                    child: const MyTitle(text: "SIGN IN")
                                  )),
                            ),
                          ],
                        ),
                        const Divider(
                            color: Colors.black, thickness: 1.5, height: 3.0),
                        createNewAccountText(),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        inputTextWidget(
                            "email", upEmailTextController),
                        inputTextWidget(
                            "password", upPassTextController),
                        inputTextWidget(
                            "username", userNameTextController),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 24, 0, 16),
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      await AuthModel().signUp(
                                          context,
                                          upEmailTextController.text.trim(),
                                          upPassTextController.text.trim(),
                                          userNameTextController.text,
                                          );
                                    },
                                    child: const MyTitle(text: "SIGN UP")
                                  )),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.black, thickness: 1.5, height: 3.0),
                        loginWithAccountText(),
                      ],
                    ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget inputTextWidget(
      String hint, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(0),
              ),
              focusColor: Colors.blue,
            ),
          ),
        );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
              text: TextSpan(
                  text: "forgot password?",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (inEmailTextController.text.isNotEmpty) {
                        AuthModel().forgotPassword(
                            context, inEmailTextController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue[200],
                            duration: const Duration(milliseconds: 700),
                            content: const Text(
                              "Enter your email",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      }
                    }))
        ],
      ),
    );
  }

  Widget createNewAccountText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: RichText(
          text: TextSpan(
              style: const TextStyle(fontSize: 16),
              children: <TextSpan>[
            const TextSpan(
                text: "Create a new account ",
                style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "Here",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _isSignIn = !_isSignIn;
                    setState(() {});
                  })
          ])),
    );
  }

  Widget loginWithAccountText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: RichText(
          text: TextSpan(
              style: const TextStyle(fontSize: 16),
              children: <TextSpan>[
            const TextSpan(
                text: "Already have an account? ",
                style: TextStyle(color: Colors.black)),
            TextSpan(
                text: "Login",
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _isSignIn = !_isSignIn;
                    setState(() {});
                  })
          ])),
    );
  }
}
