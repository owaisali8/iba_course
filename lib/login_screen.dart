import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double defaultPadding = 16.0;

var brightness = SchedulerBinding.instance.window.platformBrightness;
bool isDarkMode = brightness == Brightness.dark;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const colorIcon = Color.fromARGB(255, 245, 95, 90);
    const primaryColor = Color.fromARGB(255, 245, 95, 90);
    var bgColor = Colors.white;
    if (isDarkMode) {
      bgColor = Colors.black;
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: defaultPadding * 3),
              Row(
                children: const [
                  Spacer(),
                  Expanded(
                      flex: 5,
                      child: Icon(
                        Icons.shopping_bag,
                        color: colorIcon,
                        size: 60,
                      )),
                  Spacer()
                ],
              ),
              const SizedBox(height: defaultPadding * 4),
              Form(
                  child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding * 2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        text: "EMAIL",
                        primaryColor: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                    child: LogInTextField(
                      primaryColor: primaryColor,
                      hintText: "user@live.com",
                      type: "email",
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  Padding(
                    padding: EdgeInsets.only(left: defaultPadding * 2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        text: "PASSWORD",
                        primaryColor: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                    child: LogInTextField(
                      primaryColor: primaryColor,
                      hintText: "*********",
                      type: "password",
                    ),
                  )
                ],
              )),
              const SizedBox(height: defaultPadding * 2),
              const Padding(
                padding: EdgeInsets.only(right: defaultPadding * 2),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CustomText(
                    text: "Forgot Password?",
                    primaryColor: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding * 2),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(300, 60)),
                  onPressed: () {
                    //print("Log In pressed");
                  },
                  child: const CustomText(
                    primaryColor: Colors.white,
                    text: "LOGIN",
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: defaultPadding * 1),
              const CustomDivider(),
              const SizedBox(height: defaultPadding * 1),
              const SocialSignUp(),
              const SizedBox(height: defaultPadding * 1),
              IconButton(
                splashRadius: 1,
                  onPressed: () {
                    isDarkMode = !isDarkMode;
                    RestartWidget.restartApp(context);
                  },
                  icon: const Icon(
                    Icons.dark_mode,
                    color: colorIcon,
                    size: 30,
                  ))
            ],
          ),
        )),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Expanded(
          child: Divider(
            color: Color.fromARGB(207, 158, 158, 158),
            height: 25,
            thickness: 2,
            indent: defaultPadding * 2,
            endIndent: 9.5,
          ),
        ),
        CustomText(
          primaryColor: Color.fromARGB(207, 158, 158, 158),
          text: "OR CONNECT WITH",
          fontWeight: FontWeight.bold,
        ),
        Expanded(
          child: Divider(
            color: Color.fromARGB(207, 158, 158, 158),
            height: 25,
            thickness: 2,
            indent: 9.5,
            endIndent: defaultPadding * 2,
          ),
        )
      ],
    );
  }
}

class LogInTextField extends StatelessWidget {
  const LogInTextField(
      {Key? key,
      required this.primaryColor,
      required this.hintText,
      required this.type})
      : super(key: key);

  final Color primaryColor;
  final String hintText;
  final String type;

  @override
  Widget build(BuildContext context) {
    var keyboardType = TextInputType.emailAddress;
    var obsucre = false;
    var textInputAction = TextInputAction.next;
    var maxLength = 50;
    var textColor = Colors.black;
    var hintTextColor = const Color.fromARGB(120, 0, 0, 0);
    

    if (type == "password") {
      obsucre = true;
      keyboardType = TextInputType.text;
      textInputAction = TextInputAction.done;
      maxLength = 20;
    }

    if (isDarkMode) {
      textColor = primaryColor;
      hintTextColor = primaryColor;
    }

    return TextField(
        style: TextStyle(color: textColor),
        maxLength: maxLength,
        obscureText: obsucre,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor.withOpacity(0.5))),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          hintText: hintText,
          hintStyle:  TextStyle(color: hintTextColor.withOpacity(0.5)),
        ),
        keyboardType: keyboardType,
        textInputAction: textInputAction);
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.primaryColor,
      required this.text,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final Color primaryColor;
  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: primaryColor, fontWeight: fontWeight),
    );
  }
}

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(40),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/facebook.svg',
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText(
                      primaryColor: Colors.white,
                      text: "FACEBOOK",
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[700],
              border: Border.all(
                width: 1,
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(40),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/google-plus.svg',
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomText(
                    primaryColor: Colors.white,
                    text: "GOOGLE",
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, this.child});
 
  final Widget? child;
 
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }
 
  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }
}
 
class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
 
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }
 
 
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child ?? Container(),
    );
  }
}
