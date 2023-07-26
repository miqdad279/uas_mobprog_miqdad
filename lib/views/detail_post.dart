import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/model.dart';
import '../viewmodels/post_vm.dart';
import 'edit.dart';
import 'home.dart';

class DetailPostScreen extends StatefulWidget {
  final int id;
  final String judul;
  final String penulis;
  final String review;

  const DetailPostScreen({
    Key? key,
    required this.id,
    required this.judul,
    required this.penulis,
    required this.review,
  }) : super(key: key);

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  List dataPost = [];
  void getDataPost() async {
    PostViewModel().getPots().then((value) {
      setState(() {
        dataPost = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataPost();
  }

  Future<void> hapusPost(String id) async {
    await PostViewModel().deletePost(id);
    getDataPost();
  }

  updatePost(Post post) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditPostScreen(
              post: post,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Postingan'),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, top: 10, right: 24, bottom: 20),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.judul,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.penulis,
                      style: GoogleFonts.poppins(
                        color: const Color(0xffC7C9D9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.review,
                            textAlign: TextAlign.justify,
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    // ImageIcon(AssetImage('assets/heart.png')),
                    Icon(Icons.thumb_up_off_alt_outlined),
                    SizedBox(width: 4),
                    Text('279 K'),
                    SizedBox(width: 20),
                    Icon(Icons.insert_comment_outlined),
                    // ImageIcon(AssetImage('assets/chat.png')),
                    SizedBox(width: 4),
                    Text('138 K'),
                    SizedBox(width: 20),
                    Icon(Icons.send_rounded),
                    // ImageIcon(AssetImage('assets/send.png')),
                    SizedBox(width: 4),
                    Text('100 K'),
                  ],
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff274591),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          updatePost(Post(
                            id: widget.id.toString(),
                            judul: widget.judul,
                            penulis: widget.penulis,
                            review: widget.review,
                          ));
                        },
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 400,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff274591),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          hapusPost(widget.id.toString()).then((_) {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                          });
                        },
                        child: Text(
                          'Hapus',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
