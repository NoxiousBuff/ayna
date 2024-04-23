import 'package:ayna/src/extension/custom_color_scheme.dart';
import 'package:ayna/src/ui/shared/ui_helpers.dart';
import 'package:ayna/src/ui/views/auth/register_view.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                if (constraints.maxWidth > 1000)
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      height: double.maxFinite,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  'assets/images/auth_background.jpg'))),
                      child: const Expanded(
                          child: Text(
                        'Anya Web Chat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (constraints.maxWidth < 1000) verticalSpaceMedium,
                        if (constraints.maxWidth < 1000)
                          const Text(
                            'Anya Web Chat',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.w600),
                          ),
                        if (constraints.maxWidth < 1000) const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Get Started',
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w700),
                            ),
                            verticalSpaceMedium,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterView('Login'))),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(70),
                                      foregroundColor:
                                          Theme.of(context).colorScheme.white,
                                      textStyle: const TextStyle(fontSize: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.blue,
                                    ),
                                    child: const Text('Login'),
                                  ),
                                ),
                                horizontalSpaceRegular,
                                Flexible(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(70),
                                      foregroundColor:
                                          Theme.of(context).colorScheme.white,
                                      textStyle: const TextStyle(fontSize: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.blue,
                                    ),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterView('Sign Up'))),
                                    child: const Text('Sign Up'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        if (constraints.maxWidth < 1000) const Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
