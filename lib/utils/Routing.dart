import 'package:chehapp/pages/HomePage.dart';
import 'package:flutter/cupertino.dart';

// class Routing {
//
//   Route createRoute(Widget route, Widget hello) {
//
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => route,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         return Stack(
//           children: [
//             SlideTransition(
//               position: Tween(begin: Offset(0, 1), end: Offset.zero).animate(animation),
//               child: child,
//             ),
//             SlideTransition(
//               position: Tween(begin: Offset.zero, end: Offset(0, -1)).animate(animation),
//               child: this,
//             ),
//           ],
//         );
//       },
//     );
//   }

  // Create the route with a slide transition
  // Route createRoute(Widget route, Widget hello) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => route,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;
  //
  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       // Slide transition for the old page (child)
  //       var slideTransitionOldPage = SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //
  //       // Slide transition for the new page (route)
  //       var slideTransitionNewPage = SlideTransition(
  //         position: Tween(begin: -end, end: Offset.zero).animate(animation),
  //         child: hello,
  //       );
  //
  //       // Return a Stack with both slide transitions to achieve the desired effect
  //       return Stack(
  //         children: [
  //           slideTransitionOldPage,
  //           slideTransitionNewPage,
  //         ],
  //       );
  //     },
  //   );
  // }

// }

