import 'package:Mealhub_Group_test_project/blocs/home_bloc/home_bloc.dart';
import 'package:Mealhub_Group_test_project/blocs/home_bloc/home_event.dart';
import 'package:Mealhub_Group_test_project/middleware/repositories/api_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc(ApiRepositoryImpl())..add(LoadPostsEvent());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => _homeBloc,
        child: const Scaffold(backgroundColor: Colors.red));
  }
}
