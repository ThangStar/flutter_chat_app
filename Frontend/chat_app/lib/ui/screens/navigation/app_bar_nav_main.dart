import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seller_app/main.dart';
import 'package:seller_app/ui/screens/home_screen.dart';
import 'package:seller_app/ui/screens/utils_screen.dart';
import 'package:seller_app/utils/search_user_delegate.dart';
import '../../../services/notification_service.dart';
import '../../../model/message.dart' as MS;

import '../../../api/socket_api.dart';
import '../../../model/profile.dart';
import '../../../storages/storage.dart';
import '../../blocs/message/message_bloc.dart';
import '../../theme/color_schemes.dart';
import '../message_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppBarNavMain extends StatefulWidget {
  const AppBarNavMain({super.key});

  @override
  State<AppBarNavMain> createState() => _AppBarNavMainState();
}

class _AppBarNavMainState extends State<AppBarNavMain>
    with AutomaticKeepAliveClientMixin {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late MessageBloc messageBloc;
  bool isLoadingSearch = false;

  @override
  void initState() {
    super.initState();

    Storage.getIsDarkTheme().then((value) {
      print("is Dark: $value");

      MyApp.themeNotifier.value =
          value ?? false ? ThemeMode.dark : ThemeMode.light;
    });

    messageBloc = BlocProvider.of<MessageBloc>(context);

    Storage.getMyProfile().then((value) {
      Profile prf = Profile.fromRawJson(value ?? "");
      IO.Socket socket = SocketApi(prf.id).socket;
      if (!socket.hasListeners("messageFromServer")) {
        socket.on("messageFromServer", (data) async {
          MS.Message message = MS.Message.fromJson(data);
          messageBloc.add(HandleActionAddMessageFromServer(message: message));

          NotificationService.showNoti(
              message.idUserSend, flutterLocalNotificationsPlugin,
              (String messageInput) {
            socket.emit("messageFromClient", {
              'message': messageInput,
              'idUserGet': message.idUserSend,
              'idUserSend': prf.id.toString(),
              'dateTime': DateTime.now().toIso8601String()
            });
          }, {
            "notification": {"title": "Tin nhắn mới", "body": message.message},
            "data": {"routing": "Routing"}
          });
          // }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'Omit',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: colorScheme(context).scrim,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: SearchUserDelegate(
                              callbackLoadingState: () {
                                print("loading..");
                                setState(() {
                                  isLoadingSearch = true;
                                });
                              },
                              isLoading: isLoadingSearch,
                              callBackLoadingFinishState: () {
                                setState(() {
                                  isLoadingSearch = false;
                                });
                              }));
                    },
                  ),
                )
              ],
              pinned: true,
              floating: true,
              bottom: TabBar(
                onTap: (value) => {print(value)},
                tabs: [
                  Tab(
                      child: SvgPicture.asset(
                    "assets/svg/home.svg",
                    color: colorScheme(context).scrim,
                  )),
                  Tab(
                      child: Badge(
                          child: SvgPicture.asset(
                    "assets/svg/chat.svg",
                    color: colorScheme(context).scrim,
                  ))),
                  Tab(
                      child: SvgPicture.asset(
                    "assets/svg/menu.svg",
                    color: colorScheme(context).scrim,
                  )),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            HomeScreen(),
            MessageScreen(),
            UtilsScreen(),
          ],
        ),
      )),
    );
  }

  void initAppBar(BuildContext context, List<Widget> titles) {
    titles = [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Chào ,",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
        ),
        Text("Tin nhắn",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
      ])
    ];
  }

  @override
  bool get wantKeepAlive => true;
}
