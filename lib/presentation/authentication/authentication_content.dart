import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/cubit/auth_cubit.dart';
import 'package:digi_pikasso/cubit/content_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationContent extends StatefulWidget {
  const AuthenticationContent({
    super.key,
  });

  @override
  State<AuthenticationContent> createState() => _AuthenticationContentState();
}

class _AuthenticationContentState extends State<AuthenticationContent> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => authenticateLogin());
  }

  void authenticateLogin() {
    BlocProvider.of<AuthCubit>(context).authenticateLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailed) {
          // Show login failed dialog
          var result = showDialog<String?>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kMediumWidth, vertical: kMediumHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: const Color(0xFF009999),
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: kMediumHeight * 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              ),
            ),
          );
          result.then((value) {
            // Reset state
            BlocProvider.of<AuthCubit>(context).reset();
            // Return to login page
            BlocProvider.of<ContentCubit>(context)
                .changeView(ContentView.login);
          });
        }
        // if (state is AuthenticationSuccess) {
        //   html.window.open(state.redirectUrl, '_self');
        // }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CircularCountDownTimer(
          //   duration: 120,
          //   initialDuration: 0,
          //   controller: countDownController,
          //   width: kMediumWidth * 14,
          //   height: kMediumHeight * 14,
          //   ringColor: Colors.transparent,
          //   ringGradient: null,
          //   fillColor: const Color(0xFF009999),
          //   fillGradient: null,
          //   backgroundColor: Colors.transparent,
          //   backgroundGradient: null,
          //   strokeWidth: 10.0,
          //   strokeCap: StrokeCap.butt,
          //   textStyle: Theme.of(context)
          //       .textTheme
          //       .headlineMedium!
          //       .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
          //   textFormat: CountdownTextFormat.S,
          //   isReverse: true,
          //   isReverseAnimation: true,
          //   isTimerTextShown: true,
          //   autoStart: true,
          //   onStart: () {
          //     debugPrint('Countdown Started');
          //   },
          //   onComplete: () {
          //     BlocProvider.of<AuthCubit>(context).timerExpired();
          //   },
          //   onChange: (String timeStamp) {
          //     debugPrint('Countdown Changed $timeStamp');
          //   },
          //   timeFormatterFunction: (defaultFormatterFunction, duration) {
          //     return Function.apply(defaultFormatterFunction, [duration]);
          //   },
          // ),
          SizedBox(
            height: kMediumHeight * 3,
          ),
          Text(
            "Authenticate Your Account",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: kMediumHeight * 3,
          ),
          Text(
            "Please authenticate access on your banking app.",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
