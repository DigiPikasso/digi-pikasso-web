import 'package:digi_pikasso/config/constants.dart';
import 'package:digi_pikasso/config/size_config.dart';
import 'package:digi_pikasso/cubit/application_information_cubit.dart';
import 'package:digi_pikasso/cubit/auth_cubit.dart';
import 'package:digi_pikasso/cubit/content_cubit.dart';
import 'package:digi_pikasso/data/repositories/art_repository.dart';
import 'package:digi_pikasso/di/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ApplicationInformationCubit>(context)
        .retrieveApplicationInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationInformationCubit,
        ApplicationInformationState>(
      builder: (context, state) {
        if (state is ApplicationInformationInitial) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "NamAuthenticator",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: kMediumHeight * 3,
              ),
              Lottie.asset('assets/loading.json', frameRate: FrameRate.max),
            ],
          );
        }
        if (state is ApplicationInformationFail) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "NamAuthenticator",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: kMediumHeight * 3,
              ),
              Text(
                state.failure.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.red, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: kMediumHeight * 2,
              ),
              Text(
                'Please try again.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ],
          );
        }
        if (state is ApplicationInformationSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to ${state.information.title}",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                builder: (BuildContext context, state) {
                  if (state is AuthLoginFailed) {
                    return Column(
                      children: [
                        SizedBox(
                          height: kMediumHeight * 2,
                        ),
                        Text(
                          state.message,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
                listener: (BuildContext context, state) {
                  if (state is AuthLoginSuccess) {
                    // Go to authentication page
                    BlocProvider.of<ContentCubit>(context)
                        .changeView(ContentView.authentication);
                  }
                },
              ),
              SizedBox(
                height: kMediumHeight * 3,
              ),
              AuthInputTextField(
                controller: usernameController,
                text: "Username",
              ),
              SizedBox(
                height: kMediumHeight * 2,
              ),
              AuthInputTextField(
                controller: passwordController,
                text: "Password",
                obscureText: true,
              ),
              SizedBox(
                height: kMediumHeight * 2,
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoginInProgress) {
                    return Lottie.asset('assets/loading.json',
                        frameRate: FrameRate.max);
                  }
                  return SizedBox(
                    width: 14.18 * SizeConfig.widthMultiplier,
                    child: ElevatedButton(
                      onPressed: () {
                        if (getIt<ArtRepository>().artId == null) {
                          return;
                        }
                        String appName = getIt<ArtRepository>().artId!;
                        BlocProvider.of<AuthCubit>(context).login(
                            usernameController.text,
                            passwordController.text,
                            appName);
                      },
                      child: const Text('Login'),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class AuthInputTextField extends StatelessWidget {
  const AuthInputTextField({
    super.key,
    required this.controller,
    required this.text,
    this.obscureText = false,
  });
  final String text;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34.04 * SizeConfig.widthMultiplier,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          labelText: text,
        ),
      ),
    );
  }
}
