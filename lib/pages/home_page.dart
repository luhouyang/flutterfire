import 'package:flutter/material.dart';
import 'package:note/model/auth_model.dart';
import 'package:note/pages/add_note_page.dart';
import 'package:note/usecase/user_usecase.dart';
import 'package:note/widgets/loading_text.dart';
import 'package:note/widgets/my_dialogs.dart';
import 'package:note/widgets/note_stream.dart';
import 'package:provider/provider.dart';

// import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get user data at initState
  @override
  void initState() {
    UserUsecase userUsecase = Provider.of<UserUsecase>(context, listen: false);
    userUsecase.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserUsecase>(
      builder: (context, userUsecase, child) {
        // check if user email is empty here using ternary, if empty return LoadingText()
        return userUsecase.userEntity.email.isEmpty
            ? const Scaffold(body: LoadingText())
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  title: Row(
                    children: [
                      const Text(
                        "Hello! ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // add username here, replace placeholder
                      Text(
                        userUsecase.userEntity.username,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          // edit name dialog
                          MyDialogs().editNameDialog(context);
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () async {
                          // call auth model logout
                          await AuthModel().logout();
                        },
                        icon: const Icon(Icons.logout))
                  ],
                ),
                body: const SingleChildScrollView(
                    child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // QrImageView(
                    //   data: "$uid;${FirebaseAuth.instance.currentUser!.email!}",
                    //   gapless: true,
                    //   version: QrVersions.auto,
                    //   size: 200,
                    // ),
                    NoteStream(),
                  ],
                )),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniEndFloat,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddNotePage(),
                        ));
                  },
                ),
              );
      },
    );
  }
}
