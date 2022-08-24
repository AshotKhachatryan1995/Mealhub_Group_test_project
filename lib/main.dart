import 'package:Mealhub_Group_test_project/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:Mealhub_Group_test_project/blocs/navigation_bloc/navigation_event.dart';
import 'package:Mealhub_Group_test_project/blocs/navigation_bloc/navigation_state.dart';
import 'package:Mealhub_Group_test_project/screens/home_screen.dart';
import 'package:Mealhub_Group_test_project/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NavigationBloc _navigationBloc;

  @override
  void dispose() {
    _navigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
        create: (_) {
          _navigationBloc = NavigationBloc()..add(AppStartedEvent());

          return _navigationBloc;
        },
        child: MaterialApp(
          home: Router(routerDelegate: MyRouterDelegate()),
        ));
  }
}

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  bool showOtherPage = false;
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, navigationState) {
        print(navigationState);

        return Navigator(
            key: navigatorKey,
            pages: [
              const MaterialPage(
                key: ValueKey('LoadingScreen'),
                child: LoadingScreen(),
              ),
              if (navigationState is AuthenticatedState)
                const MaterialPage(
                  key: ValueKey('HomeScreen'),
                  child: HomeScreen(),
                ),
            ],
            onPopPage: (route, result) => route.didPop(result));
      },
    );
  }

  // We don't use named navigation so we don't use this
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
