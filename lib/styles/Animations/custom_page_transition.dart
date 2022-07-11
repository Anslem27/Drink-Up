// import 'package:flutter/material.dart';

// class CustomPageRoute extends PageRouteBuilder {
//   final Widget destination;
//   CustomPageRoute({
//     Key key,
//     this.destination,
//   }) : super(
//           transitionDuration: const Duration(seconds: 1),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             //access the initial animation
//             //and pass a different animation.
//             animation =
//                 CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn);
//             return ScaleTransition(
//               scale: animation,
//               child: child,
//               alignment: Alignment.center,
//             );
//           },
//           pageBuilder: (context, animation, secondaryAnimation) {
//             return destination;
//           },
//         );
// }

// //! Original design.
// /* 
// PageRouteBuilder(
//                       transitionDuration: const Duration(seconds: 1),
//                       transitionsBuilder:
//                           (context, animation, secondaryAnimation, child) {
//                         animation = CurvedAnimation(
//                             parent: animation, curve: Curves.elasticInOut);
//                         return ScaleTransition(
//                           scale: animation,
//                           child: child,
//                           alignment: Alignment.center,
//                         );
//                       },
//                       pageBuilder: (context, animation, secondaryAnimation) {
//                         return const Settings();
//                       },
//                     ),
//  */