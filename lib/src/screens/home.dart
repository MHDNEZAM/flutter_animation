import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import '../widgets/cat.dart';
import 'dart:math';
class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;

  Animation<double> boxAnimation;
  AnimationController boxController;


  initState(){
    super.initState();

    boxController = AnimationController(
      duration: Duration(microseconds: 800),
      vsync: this,
    );

    boxAnimation = Tween(begin: pi * 0.6 ,end: pi *0.65,).animate(
        CurvedAnimation(
            parent: boxController,
          curve: Curves.linear,
        ),
    );

    catController = AnimationController(
      duration: Duration(microseconds: 200),
      vsync: this,

    );

    catAnimation = Tween(begin: -35.0,end: -80.0)
    .animate(
        CurvedAnimation(
          parent: catController,
          curve:  Curves.easeIn,
        ),
    );

    boxAnimation.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        boxController.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        boxController.forward();
      }
    });
 boxController.forward();
  }

  onTap(){


    if(catController.status== AnimationStatus.completed){
      catController.reverse();
      boxController.forward();
    }
    else if(catController.status==AnimationStatus.dismissed){
      catController.forward();
      boxController.stop();
    }

    else if(catController.status== AnimationStatus.forward){
      catController.reverse();
    }
    else if(catController.status==AnimationStatus.reverse) {
      catController.forward();
    }

  }

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child:
          Stack(
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
          ],
            overflow: Overflow.visible,
        ),
        ),
        onTap: onTap,
      ) ,
    );
  }

  Widget buildCatAnimation(){
    return AnimatedBuilder(
        animation: catAnimation,
        builder: (context,child) {
          return Positioned(
              child: child,
            top: catAnimation.value ,
            left: 0.0,
            right: 0.0,
          );
        },
          child: Cat(),
    );
  }

  Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap(){
    return Positioned(
      left: 3.0,
      child:AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
          builder: (context,child){
            return Transform.rotate(
              child: child,
              alignment: Alignment.topLeft,
              angle: boxAnimation.value,
            );
          },
      ) ,
    ) ;
  }

  Widget buildRightFlap(){
    return Positioned(
      right: 3.0,
      child:AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context,child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: boxAnimation.value * -1,
          );
        },
      ) ,
    ) ;
  }
}


