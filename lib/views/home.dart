import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_mobprog_miqdad/views/detail_post.dart';
import 'package:uas_mobprog_miqdad/views/profile.dart';

import '../models/model.dart';
import '../viewmodels/post_vm.dart';
import 'create.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> dataPost = [];
  void navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataPost();
  }

  void getDataPost() async {
    PostViewModel().getPots().then((value) {
      setState(() {
        dataPost = value.reversed.toList();
      });
    });
  }

  hapusPost(String id) {
    PostViewModel().deletePost(id).then((value) => getDataPost());
  }

  updatePost(Post post) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EditPostScreen(
              post: post,
            )));
  }

  Widget post(Post data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.person, size: 15),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Profile Name',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('Caption...')
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        'https://cdn.gramedia.com/uploads/picture_meta/2023/1/17/nrpnlqrnjwert2kmd2z2zt.jpg',
                        width: 100,
                      ),
                      Text(
                        data.judul,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        data.penulis,
                        style: GoogleFonts.poppins(
                          color: const Color(0xffC7C9D9),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            size: 20,
                            color: Color(0xffC7C9D9),
                          ),
                          SizedBox(width: 4),
                          Text('279K'),
                          SizedBox(width: 16),
                          Icon(
                            Icons.comment_outlined,
                            size: 20,
                            color: Color(0xffC7C9D9),
                          ),
                          SizedBox(width: 4),
                          Text('138K'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 0.5,
            width: 500,
            color: const Color(0xffC7C9D9),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    dataPost.sort((a, b) => b.id.compareTo(a.id));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Beranda'),
          leading: null,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          elevation: 0,
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: navigateToProfilePage,
                  child: const CircleAvatar(
                    radius: 15,
                    child: Icon(Icons.person, size: 15),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 24, top: 30, right: 24),
            child: Column(
              children: [
                for (var item in dataPost)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPostScreen(
                            id: int.parse(item.id),
                            judul: item.judul,
                            penulis: item.penulis,
                            review: item.review,
                          ),
                        ),
                      );
                    },
                    child: post(item),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreatePostScreen()))
          },
          heroTag: 'createNew',
          backgroundColor: const Color(0xFF242569),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

void showNotification(BuildContext context, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
  );
}
