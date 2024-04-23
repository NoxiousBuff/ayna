import 'package:ayna/src/bloc/auth/auth_bloc.dart';
import 'package:ayna/src/bloc/auth/auth_event.dart';
import 'package:ayna/src/extension/custom_string.dart';
import 'package:ayna/src/models/user.dart';
import 'package:ayna/src/repository/firestore_repo.dart';
import 'package:ayna/src/ui/chat/chat_view.dart';
import 'package:ayna/src/ui/views/auth/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ScaffoldMessenger(
            key: _scaffoldKey,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Anya Web Chat',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!
                          .showMaterialBanner(MaterialBanner(
                              content: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Do you want to logout?'),
                                ],
                              ),
                              actions: [
                            TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(Logout());
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AuthView()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!
                                      .hideCurrentMaterialBanner();
                                },
                                child: const Text('No')),
                          ]));
                    },
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    icon: const Icon(Icons.logout),
                  )
                ],
              ),
              body: Row(
                children: [
                  Expanded(
                    flex: constraints.maxWidth > 1000 ? 3 : 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text('Users'),
                        ),
                        Container(
                          margin: constraints.maxWidth > 650
                              ? const EdgeInsets.symmetric(horizontal: 15)
                              : null,
                          child: ListTile(
                            onTap: constraints.maxWidth < 650
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ChatView(),
                                      ),
                                    );
                                  }
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tileColor: constraints.maxWidth > 650
                                ? Colors.black12.withAlpha(10)
                                : Colors.white,
                            title: const Text(
                              'Server',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: const Text(
                              'wss://echo.websocket.org',
                              style: TextStyle(color: Colors.black54),
                            ),
                            leading: ClipOval(
                              child: Container(
                                color: Colors.blue.withOpacity(0.1),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  "S",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: StreamBuilder(
                            stream: FireStoreRepo().subsCollection.snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text('Some Error Occured'),
                                );
                              }
                              if (snapshot.data != null &&
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(child: Text('No Users'));
                              }
                              if (snapshot.data != null) {
                                final userdocs = snapshot.data!.docs;
                                return ListView.builder(
                                  itemCount: userdocs.length,
                                  itemBuilder: (context, i) {
                                    FirebaseUser user =
                                        FirebaseUser.fromFireStore(userdocs[i]);

                                    return Container(
                                      margin: constraints.maxWidth > 650
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 15)
                                          : null,
                                      child: ListTile(
                                        title: Text(
                                          user.name.capitalize(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        subtitle: Text(
                                          user.email,
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                        leading: ClipOval(
                                          child: Container(
                                            color: Colors.blue.withOpacity(0.1),
                                            height: 50,
                                            width: 50,
                                            alignment: Alignment.center,
                                            child: Text(
                                              user.name.capitalize()[0],
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (constraints.maxWidth > 650)
                    Expanded(
                      flex: constraints.maxWidth > 1000 ? 7 : 6,
                      child: ChatView(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
