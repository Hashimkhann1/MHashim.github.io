import 'package:myportfolio/res/widgets/my_text_button.dart';
import 'package:myportfolio/view.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> with TickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> headingBackAnimation;
  late Animation<double> textRevealAnimation;
  late Animation<double> textOpicatyAnimation;
  late Animation<double> imageReveal;
  late Animation<double> imageOpacity;

  @override
  void initState() {

    controller = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 3000),
      reverseDuration: const Duration(milliseconds: 375),
    );

    imageReveal = Tween<double>(begin: 0.0, end: 170.0).animate(CurvedAnimation(
        parent: controller, curve: const Interval(0.0, 0.7, curve: Curves.easeOut)));

    imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: const Interval(0.0, 0.7, curve: Curves.easeOut)));

    headingBackAnimation = Tween<double>(begin: 0.0 ,end: 1.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.3, 0.5 , curve: Curves.easeOut),));

    textRevealAnimation  = Tween<double>(begin: 100.0, end: 0.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.3 , curve: Curves.easeOut)));
    
    textOpicatyAnimation  = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.3 , curve: Curves.easeOut)));


    Future.delayed(const Duration(milliseconds: 1000),() {
      controller.forward();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: controller,
      builder: (context , child) {
        return Column(
          children: [
            SizedBox(height: Responsive.isMobile(context) ? height * 0.01 : height * 0.1,),
            SizedBox(
              height: Responsive.isMobile(context) ? 154 : 180,
              width: Responsive.isMobile(context) ? 154 : 180,
              child: Center(
                child: FadeTransition(
                  opacity: imageOpacity,
                  child: SizedBox(
                    width: imageReveal.value,
                    height: imageReveal.value,
                    child: const CircleAvatar(
                      backgroundColor: Colors.black38,
                      radius: 100,
                      // backgroundImage: AssetImage('assets/images/profile.jpg'),
                      backgroundImage: NetworkImage('https://i.imgur.com/0BY42Xv_d.jpg?maxwidth=520&shape=thumb&fidelity=high'),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: Responsive.isMobile(context) ? height * 0.02 : height * 0.02),

            MyTitleText(title: "Flutter Developer",fontSize: 42,maxHeight: 90.0,controller: controller,),

            SizedBox(height: Responsive.isMobile(context) ?height * 0.02 : height * 0.01),

            SizedBox(
              width: Responsive.isMobile(context) ? width * 0.92 : Responsive.isTablet(context) ? width * 0.86 :  width * 0.68,
              child: FadeTransition(
                opacity: textOpicatyAnimation,
                child: MyText(
                  title:
                  "For over a decade, I’ve mastered the craft of turning code into dynamic, functional experiences. As a Flutter developer, I create seamless cross-platform apps, blending creativity with technical skill. From bringing ideas to life on the web to crafting elegant mobile solutions, I have the expertise to transform visions into reality.",
                  fontSize: Responsive.isMobile(context) ? 18 : 26,
                  letterSpacing: 1.2,
                  fontFamily: 'Oswald',
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold,
                  textAlign: Responsive.isMobile(context) ? TextAlign.start : TextAlign.center,
                ),
              )
            ),

            SizedBox(height: Responsive.isTablet(context) ? 30 :  height * 0.026,),

            MyTextButton(title: "About Me", onPressed: (){} , fontSize: 22,width: 160,height: 52,backgroundColor: Colors.transparent,borderColor: Colors.greenAccent.withOpacity(0.8),),

            SizedBox(height: Responsive.isMobile(context) ? height * 0.02 : Responsive.isTablet(context) ? 0 : height * 0.06,)
          ],
        );
      }
    );
  }
}

