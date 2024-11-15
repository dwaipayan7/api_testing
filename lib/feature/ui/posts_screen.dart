import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts Page", style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listenWhen: (previous,current) => current is PostActionState,
        buildWhen: (previous,current) => current is !PostActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;
              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                    itemBuilder: (context,index){
                      return Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.posts[index].title),
                            Text(successState.posts[index].body)
                          ],
                        ),
                      );
                    }
                ),
              );
              break;

            case PostFetchingLoadingState:
              return Center(child: CircularProgressIndicator.adaptive(),);

            case PostFetchingErrorState:
              return Center(child: Text("Getting Error While Fetching", style: TextStyle(
                color: Colors.red
              ),),);
          }
          return Container();
        },
      ),
    );
  }
}
