import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/api/api.dart';
import 'package:seller_app/ui/theme/color_schemes.dart';
import 'package:seller_app/ui/widgets/avatar.dart';

import '../model/profile.dart';
import '../ui/blocs/search/search_bloc.dart';

class SearchUserDelegate extends SearchDelegate {
  final Function() callbackLoadingState;
  final Function() callBackLoadingFinishState;
  final bool isLoading;

  SearchUserDelegate(
      {required this.callbackLoadingState,
      required this.isLoading,
      required this.callBackLoadingFinishState});
  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 18,
      );

  @override
  String? get searchFieldLabel => 'Tìm kiếm tên..';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {},
          icon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            },
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            close(context, null);
          },
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<SearchBloc>().add(HandleSearchEvent(query: query));
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchProgress) {
          callbackLoadingState();
        } else if (state is SearchFinish) {
          callBackLoadingFinishState();
        }
      },
      builder: (context, state) {
        return state.profiles.length == 0
            ? ListTile(
                title: RichText(
                    text: TextSpan(
                        style: TextStyle(color: colorScheme(context).scrim),
                        text: "Không tìm thấy tài khoản ",
                        children: [
                    TextSpan(
                        style: TextStyle(
                            color: colorScheme(context).scrim,
                            fontWeight: FontWeight.bold),
                        text: query)
                  ])))
            : ListView.builder(
                itemCount: state.profiles.length,
                itemBuilder: (context, index) {
                  Profile user = state.profiles[index];
                  return ListTile(
                    onTap: () {},
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.person_add,
                        color: Colors.green,
                      ),
                    ),
                    leading: Avatar(url: user.avatar),
                    title: Text(user.username),
                  );
                });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: [
      ListTile(
        onTap: () {},
        leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.person_add,
              color: Colors.green,
            )),
        title: const Text("Thêm người bạn mới"),
      ),
      ListTile(
        onTap: () {},
        leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add_reaction_rounded,
              color: Colors.pinkAccent,
            )),
        title: const Text("Tạo cuộc trò truyện mới"),
      )
    ]);
  }
}
