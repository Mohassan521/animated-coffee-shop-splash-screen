import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;
  bool isGreenCoffee = false;
  bool isTextReady = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Color(0xffccbb381),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight / 1.6 : screenHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(copAnimated ? 40 : 0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !copAnimated,
                  child: Lottie.asset(
                      backgroundLoading: true,
                      "assets/coffee_animation.json",
                      controller: _coffeeController, onLoaded: (composition) {
                    _coffeeController
                      ..duration = composition.duration
                      ..forward();
                  }),
                ),
                Visibility(
                  visible: copAnimated,
                  child: Lottie.asset(
                    "assets/coffee2.json",
                    width: 190,
                    height: 190,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                      opacity: animateCafeText ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: const Text(
                        "Coffee Shop",
                        style: TextStyle(
                            letterSpacing: 10,
                            fontSize: 33,
                            color: Color(0xff632B13)),
                      )),
                ),
              ],
            ),
          ),
          Visibility(visible: copAnimated, child: const _BottomPart())
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 105.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              height: MediaQuery.sizeOf(context).height * 0.058,
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16.5),
              ),
              textColor: Colors.white,
              minWidth: MediaQuery.sizeOf(context).width * 0.65,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 22,
            ),
            MaterialButton(
              height: MediaQuery.sizeOf(context).height * 0.058,
              onPressed: () {},
              child: Text(
                "Register",
                style: TextStyle(fontSize: 16.5),
              ),
              textColor: Colors.white,
              minWidth: MediaQuery.sizeOf(context).width * 0.65,
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: Container(
            //     height: 85.0,
            //     width: 85.0,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: Colors.white, width: 2.0),
            //     ),
            //     child: const Icon(
            //       Icons.chevron_right,
            //       size: 50.0,
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
