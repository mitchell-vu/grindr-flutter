import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialsLogin extends StatelessWidget {
  final VoidCallback? onLoginGoogle;

  const SocialsLogin({super.key, this.onLoginGoogle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        ElevatedButton(
          onPressed: onLoginGoogle,
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/svgs/google.svg'),
              ),
              Text('Sign in with Google'),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset('assets/svgs/facebook.svg'),
              ),
              Text('Sign in with Facebook'),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  'assets/svgs/apple.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Text('Sign in with Apple'),
            ],
          ),
        ),
      ],
    );
  }
}
