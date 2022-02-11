import 'package:flutter/material.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:news_app/widgets/turkey_news.dart';
import 'package:news_app/widgets/us_news.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late NewsViewModel _newsViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _data();
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("News"),
        ),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            child: Text("TR"),
          ),
          Tab(
            child: Text("US"),
          )
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TurkeyNews(
            context: context,
          ),
          UsNews(
            context: context,
          )
        ],
      ),
    );
  }

  _data() async {
    await _newsViewModel.getTurkeyyNews();
    await _newsViewModel.getUsNews();
  }
}
