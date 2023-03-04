import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/web_view.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return WebView(url: article['url']);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: article['urlToImage'] == null
                      ? const NetworkImage(
                          'https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg')
                      : NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => list.isEmpty
    ? isSearch
        ? Container()
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.cyan,
          ))
    : ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

bool isNetworkConnection = true;
Future<void> internetConection(context) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isNetworkConnection = true;
    }
  } on SocketException catch (_) {
    isNetworkConnection = false;
    showSnackBar(context, 'Please Check Your Internet');
    // showTopSnackBar(
    //     context,
    //     const CustomSnackBar.success(
    //       backgroundColor: Colors.red,
    //       message: 'Please Check Your Internet',
    //       // icon: Icon(null),
    //     ),
    //   );
  }
}

showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      )));
}
