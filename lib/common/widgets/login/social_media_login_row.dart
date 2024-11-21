import 'package:flutter/material.dart';

class SocialMediaLoginRow extends StatelessWidget {
  final Function()? onGoogleSignInOrSignUP;
  final Function()? onNaverSignInOrSignUP;
  final Function()? onKakaoSignInOrSignUP;
  final Function()? onFacebookSignInOrSignUP;
  final Function()? onAppleSignInOrSignUP;

  const SocialMediaLoginRow({
    super.key,
    this.onGoogleSignInOrSignUP,
    this.onNaverSignInOrSignUP,
    this.onKakaoSignInOrSignUP,
    this.onFacebookSignInOrSignUP,
    this.onAppleSignInOrSignUP,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google
        IconButton(
          onPressed: onGoogleSignInOrSignUP,
          icon: SizedBox(
            width: 46,
            height: 46,
            child: Image.asset('assets/logos/search.png'),
          ),
        ),
        // Naver
        IconButton(
          onPressed: onNaverSignInOrSignUP,
          icon: SizedBox(
            width: 46,
            height: 46,
            child: Image.asset('assets/logos/naver.png'),
          ),
        ),
        // Kakao
        IconButton(
          onPressed: onKakaoSignInOrSignUP,
          icon: SizedBox(
            width: 46,
            height: 46,
            child: Image.asset('assets/logos/kakao-talk.png'),
          ),
        ),
        // Facebook
        IconButton(
          onPressed: onFacebookSignInOrSignUP,
          icon: SizedBox(
            width: 46,
            height: 46,
            child: Image.asset('assets/logos/facebook.png'),
          ),
        ),
        // Apple
        IconButton(
          onPressed: onAppleSignInOrSignUP,
          icon: SizedBox(
            width: 46,
            height: 46,
            child: Image.asset('assets/logos/apple.png'),
          ),
        ),
      ],
    );
  }
}
