import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/injector.dart';
import 'package:food_store/logic/all_blocs.dart';
import 'package:food_store/presentation/config/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/models/location_model.dart';
import 'presentation/all_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(() => runApp(MyApp()), storage: storage);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Injector _injector = Injector();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: AppTheme().buildLightTheme(),
    );
  }

  late final _router = GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: GoRouterRefreshStream(_injector.appBloc.stream),
      redirect: (state) {
        final status = _injector.appBloc.state.status;
        final headingToSignin = state.subloc == '/signin';
        if (status == AppStatus.noUser) {
          return headingToSignin ? null : '/signin';
        }
        if (status == AppStatus.hasLocation || status == AppStatus.noLocation) {
          return headingToSignin ? '/' : null;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          redirect: (state) {
            final status = _injector.appBloc.state.status;

            final headingToCatalog = state.subloc == '/catalog';
            if (status == AppStatus.hasLocation)
              return headingToCatalog ? null : '/catalog';

            final headingToLocation = state.subloc == '/location_search';
            if (status == AppStatus.noLocation)
              return headingToLocation ? null : '/location_search';

            return null;
          },
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => BlocProvider.value(
            value: _injector.authBloc,
            child: const SigninScreen(),
          ),
        ),
        GoRoute(
            path: '/location_search',
            builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _injector.suggestionsBloc),
                    BlocProvider.value(value: _injector.locationBloc),
                  ],
                  child: const LocationSearchScreen(),
                ),
            routes: [
              GoRoute(
                path: ':details',
                builder: (context, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _injector.locationBloc),
                    BlocProvider.value(value: _injector.appBloc),
                  ],
                  child: LocationDetailsScreen(
                    location: state.extra! as Location,
                  ),
                ),
              ),
            ]),
        GoRoute(
          path: '/location_choose',
          builder: (context, state) => BlocProvider.value(
            value: _injector.appBloc,
            child: const LocationChooseScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => BlocProvider.value(
            value: _injector.appBloc,
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/order',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _injector.cartBloc),
              BlocProvider.value(value: _injector.appBloc),
              BlocProvider.value(value: _injector.orderCubit),
            ],
            child: const OrderScreen(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                var map = (state.extra! as Map<Item, int>);
                return BlocProvider.value(
                  value: _injector.itemCubit
                    ..passItemForEdit(map.keys.first, map.values.first),
                  child: ItemScreen(item: map.keys.first.copyWith()),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/catalog',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _injector.catalogBloc),
              BlocProvider.value(value: _injector.itemCubit),
              BlocProvider.value(value: _injector.appBloc),
              BlocProvider.value(value: _injector.cartBloc),
              BlocProvider(create: ((context) => AnimBarCubit())),
              BlocProvider(create: ((context) => AnimCartTileCubit())),
            ],
            child: const CatalogScreen(),
          ),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                return BlocProvider.value(
                  value: _injector.itemCubit..passItem(state.extra! as Item),
                  child: ItemScreen(item: (state.extra! as Item).copyWith()),
                );
              },
            ),
          ],
        ),
      ]);
}
