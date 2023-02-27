import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iba_course/models/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  Future<List<Comment>>? _futureComments;

  @override
  void initState() {
    _futureComments = fetchComment();
    super.initState();
  }

  Future<List<Comment>>? fetchComment() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Future<List<Comment>>?> _refresh(BuildContext context) async {
    _futureComments = fetchComment();
    setState(() {});
    return _futureComments;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => _refresh(context),
          child: FutureBuilder<List<Comment>>(
            future: _futureComments,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //api data 200
                var data = snapshot.data!;
                return ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCardListView(data: data, index: index);
                    });
              } else if (snapshot.hasError) {
                //api error
                return Center(
                    child: SingleChildScrollView(
                        child: Container(
                  alignment: Alignment.center,
                  height: 950,
                  width: 500,
                  child: const Text("Error"),
                )));
              }

              // By default, show a loading spinner.
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
}

class CustomCardListView extends StatelessWidget {
  const CustomCardListView({Key? key, required this.data, required this.index})
      : super(key: key);

  final List<Comment> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, left: 8.0, right: 8.0, bottom: 32.0),
                    child: Card(
                      elevation: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Name: ${data[index].name}"),
                            Text("Email: ${data[index].email}"),
                            Text("Body: ${data[index].body}"),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  '${data[index].id}',
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )),
          title: Text(
            data[index].name,
          )),
    );
  }
}
