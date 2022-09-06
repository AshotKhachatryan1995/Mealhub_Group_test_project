import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../blocs/home_bloc/home_bloc.dart';
import '../blocs/home_bloc/home_event.dart';
import '../blocs/home_bloc/home_state.dart';
import '../middleware/models/post.dart';
import '../middleware/notifiers/posts_notifier.dart';
import '../middleware/repositories/api_repository_impl.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;
  late PostsNotifier _postsNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _postsNotifier = Provider.of<PostsNotifier>(context, listen: false);
  }

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
        child: BlocListener<HomeBloc, HomeState>(
            listener: _listener,
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Consumer<PostsNotifier>(
                        builder: (context, notifier, child) => ListView.builder(
                            itemCount: notifier.posts.length,
                            itemBuilder: (context, index) =>
                                _renderPostItem(notifier.posts[index])))))));
  }

  Widget _renderPostItem(Post post) {
    Widget renderPostDetails() {
      return Flexible(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title.substring(0, 10),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Text(
            post.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ));
    }

    return GestureDetector(
        onTap: _onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              _renderImageArea(),
              const SizedBox(width: 20),
              renderPostDetails()
            ])));
  }

  Widget _renderImageArea() {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey),
      child: const Text(
        'New Post',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}

extension _HomeScreenStateAddition on _HomeScreenState {
  void _listener(context, state) {
    if (state is PostsLoadedState) {
      _postsNotifier.loadPosts(posts: state.posts);
    }
  }

  void _onTap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DetailsScreen()));
  }
}
