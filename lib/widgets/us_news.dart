import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UsNews extends StatefulWidget {
  BuildContext context;
  UsNews({required this.context, Key? key}) : super(key: key);

  @override
  State<UsNews> createState() => _UsNewsState();
}

class _UsNewsState extends State<UsNews> {
  late NewsViewModel _newsViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _newsViewModel = Provider.of<NewsViewModel>(context);
    return _newsViewModel.state == NewsCheck.NewsLoadedState
        ? gelenList(context)
        : _newsViewModel.state == NewsCheck.NewsLoadingState
            ? newsGetiriliyor()
            : _newsViewModel == NewsCheck.NewsErrorState
                ? newsHata()
                : Center(
                    child: Text("No Data"),
                  );
  }

  Widget gelenList(BuildContext context) {
    var trNews = _newsViewModel.usArticles;
    return ListView.builder(
      itemCount: trNews.length,
      itemBuilder: (context, index) {
        var gelenNews = trNews[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => _lanuchUrl(gelenNews.url),
            child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    newsImageBlog(context, gelenNews),
                    newsTitleMetod(gelenNews),
                    newsContentMetod(gelenNews),
                    SizedBox(
                      height: 5,
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  Padding newsContentMetod(Articles gelenNews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: gelenNews.content.toString() != null
          ? Text(
              gelenNews.content.toString() != "null"
                  ? gelenNews.content.toString()
                  : "",
              style: TextStyle(color: Colors.grey),
            )
          : Text(""),
    );
  }

  Padding newsTitleMetod(Articles gelenNews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(gelenNews.title.toString()),
    );
  }

  Stack newsImageBlog(BuildContext context, Articles gelenNews) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: gelenNews.urlToImage != null ? Image.network(
            gelenNews.urlToImage.toString(),
            fit: BoxFit.cover,
          ): Center(child: Text("No Image"),),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Chip(label: Text(gelenNews.author != null ?gelenNews.author.toString():"Source Unknown"))),
        ),
        Positioned(
          bottom: 1,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Chip(
                  label: Text(DateFormat.yMEd().format(
                      DateTime.parse(gelenNews.publishedAt.toString()))))),
        ),
      ],
    );
  }

  newsGetiriliyor() {
    return Center(child: CircularProgressIndicator());
  }

  newsHata() {
    return Center(
      child: Text("Veride Hata "),
    );
  }

  _lanuchUrl(String? url) async {
    
    try{
        await launch(url!,forceWebView: true);
    } catch(e){} 
            
  }
}
