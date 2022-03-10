// import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:food_store/injector.dart';
// import 'package:go_router/go_router.dart';

// import '../../data/models/item_model.dart';
// import '../all_screens.dart';

// class MyRouter {
//   final LoginState loginState;
//   Injector _injector = new Injector();
//   MyRouter(this.loginState);

//   late final _router = GoRouter(
//       refreshListenable: loginState,
//       debugLogDiagnostics: true,
//       redirect: (state) {},
//       routes: [
//         GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
//         GoRoute(
//             path: '/signin',
//             builder: (context, state) => BlocProvider.value(
//                   value: _injector.authBloc,
//                   child: const SigninScreen(),
//                 )),
//         GoRoute(
//           path: '/order',
//           builder: (context, state) => BlocProvider.value(
//             value: _injector.cartBloc,
//             child: const OrderScreen(),
//           ),
//         ),
//         GoRoute(
//             path: '/catalog',
//             builder: (context, state) => MultiBlocProvider(
//                   providers: [
//                     BlocProvider.value(
//                       value: _injector.catalogBloc,
//                     ),
//                     BlocProvider.value(
//                       value: _injector.itemCubit,
//                     ),
//                   ],
//                   child: const CatalogScreen(),
//                 ),
//             routes: [
//               GoRoute(
//                 path: ':id',
//                 builder: (context, state) {
//                   return BlocProvider.value(
//                     value: _injector.itemCubit..passItem(state.extra! as Item),
//                     child: ItemScreen(item: (state.extra! as Item).copyWith()),
//                   );
//                 },
//               )
//             ]),
//       ],
//       errorBuilder: (context, state) =>
//           Scaffold(body: Center(child: Text(state.error.toString()))));
// }
