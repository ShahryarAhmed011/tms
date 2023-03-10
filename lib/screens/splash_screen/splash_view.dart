import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/core/constants/strings.dart';
import 'package:tms/screens/splash_screen/splash_view_model.dart';
import 'package:tms/utils/app_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration:  const BoxDecoration(
                      color: AppColors.primaryThemeColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(100),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100,),
                        Center(
                          ///Lottie animation to play animation from json file
                          child: Lottie.asset('assets/animations/tms.json',height: 300,),
                        ),
                        const SizedBox(height: 30,),
                        ///animatedTagLine is a function which returns a widget
                      animatedTagLine()
                      ],
                    ),
                  ),

              ),
              Expanded(
                  flex: 1,
                  child: Center(

                    child: InkWell(
                      ///onTap is used to navigate to next screen
                    onTap: () {
                        model.navigate();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 80.0,vertical: 16.0),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryThemeColor,
                            border: Border.all(
                              color: AppColors.primaryTextColor,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Text(Strings.getStarted,style: TextStyle(color: AppColors.primaryTextColor)),
                      ),
                    ),
                  )
              )
            ],
          ),
        );
      },
      ///ViewModelBuilder is used to create the viewmodel object and pass it to the builder function
      viewModelBuilder: () => SplashViewModel(),
    );
  }

  /// This function creates and returns an animated tagline in the form of
  /// [AnimatedTextKit] widget. The animation is a typewriter animation
  /// with a text [Strings.appTagLine] and speed of 100 milliseconds.
  Widget animatedTagLine(){
    return Center(
      child: SizedBox(
        width: 300,
        child: DefaultTextStyle(
          style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Agne',
              fontWeight: FontWeight.bold,
              color: AppColors.primaryTextColor,

          ),
          child: AnimatedTextKit(
            isRepeatingAnimation: false,
            animatedTexts: [
              TypewriterAnimatedText(Strings.appTagLine,speed: const Duration(milliseconds: 100),textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

}
