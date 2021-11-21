import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/modules/web_view/show_news.dart';

Widget buildListViewItemNews({
  required news,
  required BuildContext context,
}) =>
    GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (Context) => ShowNews(news['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image(
                image: NetworkImage(((news['urlToImage'] == null) ||
                        (news['urlToImage'].toString().contains('?')))
                    ? 'https://www.logaster.com/blog/wp-content/uploads/2020/03/1010.png'
                    : news['urlToImage'].toString()),
                height: 120,
                width: 120,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${news['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${news['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
