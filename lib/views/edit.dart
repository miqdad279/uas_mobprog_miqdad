import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../viewmodels/post_vm.dart';
import 'home.dart';

// ignore: must_be_immutable
class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
// ignore: no_logic_in_create_state
  State<EditPostScreen> createState() => _EditPostScreenState(post);
}

class _EditPostScreenState extends State<EditPostScreen> {
  Post? post;
  _EditPostScreenState(this.post);
  late final TextEditingController _textIDController = TextEditingController();
  late final TextEditingController _textJudulController =
      TextEditingController();
  late final TextEditingController _textPenulisController =
      TextEditingController();
  late final TextEditingController _textReviewController =
      TextEditingController();

  late String penulis = "", review = "", judul = "";
  @override
  void initState() {
    super.initState();

    _textIDController.text = post!.id;
    _textJudulController.text = post!.judul;
    _textPenulisController.text = post!.penulis;
    _textReviewController.text = post!.review;
    judul = post!.judul;
    penulis = post!.penulis;

    review = post!.review;
  }

  updatePost() async {
    if ((penulis == "") || (review == "") || (judul == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black,
          textColor: Colors.white);
    } else {
      showLoaderDialog(context);
      PostViewModel().editPost(post!.id, judul, penulis, review).then((value) {
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      });
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Postingan'),
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
            padding: const EdgeInsets.only(left: 24, top: 10, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Judul Buku',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff404040),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _textJudulController,
                  onChanged: (e) => judul = e,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Penulis',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff404040),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _textPenulisController,
                  onChanged: (e) => penulis = e,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Review Buku',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff404040),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _textReviewController,
                  onChanged: (e) => review = e,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xffDDE5E9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff274591),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: () {
                      updatePost();
                    },
                    child: Text(
                      'Update',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
