import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double defaultPadding = 16.0;

class Background extends StatelessWidget {
  
  final Widget child;
  final String topImage, bottomImage;

  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            SafeArea(
                child:
                    Padding(padding: const EdgeInsets.all(16), child: child)),
            Align(
              alignment: Alignment.bottomRight,
              child: Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Image.asset(
                  bottomImage,
                  width: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding * 2),
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset("assets/icons/login.svg"),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: defaultPadding * 2),
            Form(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding:  EdgeInsets.all(defaultPadding),
                          child:  Icon(Icons.person),
                        ),
                        hintText: "Your email",
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onChanged: (value) {
                      // do something
                    },

                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    //cursorColor: kPrimaryColor,
                    //onSaved: (email) {},
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      //cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.lock),
                          ),
                          hintText: "Your password",
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Doing everything");
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        minimumSize: const Size(200, 40),
                        shadowColor: Colors.grey,
                        elevation: 5,
                        side: const BorderSide(
                            color: Colors.transparent,
                            width: 2,
                            style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        tapTargetSize: MaterialTapTargetSize.padded,
                      ),
                      child: const Text("LOGIN"),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SocialSignUp(),
                  const SizedBox(height: defaultPadding),
                ],
              ),
            ),
          ],
        ),
      ),
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
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[900],
              border: Border.all(
                width: 2,
                color: Colors.transparent,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/facebook.svg',
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(
                width: 2,
                color: Colors.transparent,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/google-plus.svg',
              height: 20,
              width: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
