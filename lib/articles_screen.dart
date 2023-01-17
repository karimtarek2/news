import 'package:flutter/material.dart';
import 'package:news_app/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'category.dart';

class ArticlesScreen extends StatefulWidget {
  ArticlesScreen({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Category article;

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  late SharedPreferences preferences;
  String reTags = '';

  Future init() async {
    preferences = await SharedPreferences.getInstance();
    String? reTags = preferences.getString('reTags');
    if (reTags == null) return;
    setState(() => this.reTags = reTags);
    // print(preferences);
    print(reTags);
  }

  late TextEditingController controller;
  String name = '';

  @override
  void initState() {
    super.initState();
    init();
    controller = TextEditingController(
      text: Provider.of<MyProvider>(context, listen: false)
          .tags(widget.article.id)
          .toString(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MyProvider>(context, listen: false)
              .toggleFavorite(widget.article);
        },
        foregroundColor: Colors.red[500],
        backgroundColor: Colors.pink[100],
        child: Provider.of<MyProvider>(context).isFavorite(widget.article.id)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
      appBar: AppBar(
        title: Text(
          widget.article.title,
          maxLines: 2,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.article.image),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.article.desc,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        preferences.setString(
                          "reTags",
                          Provider.of<MyProvider>(context, listen: false)
                              .tags(widget.article.id)
                              .toString(),
                        );
                        final name = await openDialog();
                        if (name == null || name.isEmpty) return;
                        setState(() =>
                            // Provider.of<MyProvider>(context, listen: false)
                            //     .name = name);
                            Provider.of<MyProvider>(context, listen: false)
                                .addTagsId(widget.article.id, name));
                      },
                      child: const Text('Hash Tag'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SelectableText(
                  Provider.of<MyProvider>(context, listen: false)
                      .tags(widget.article.id)
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (builder) => AlertDialog(
            title: const Text('Your Hash Tag'),
            content: TextField(
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: "Enter your hash tag"),
              controller: controller,

              //onSubmitted: (_) => submit(),
            ),
            actions: [
              TextButton(onPressed: submit, child: const Text('SUBMIT'))
            ],
          ));

  void submit() {
    Navigator.of(context).pop(controller.text);
  }
}
