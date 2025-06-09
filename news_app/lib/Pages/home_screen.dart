import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/category_news_model.dart';
import 'package:news_app/Models/news_channel_headline_model.dart';
import 'package:news_app/Pages/category_screen.dart';
import 'package:news_app/Pages/news_detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum filterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  filterList? selectedMenu;

  final format = DateFormat('MMM dd,YYYY');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen()),
            );
          },
          icon: Image.asset('images/category_icon.png', height: 30, width: 30),
        ),
        title: Text(
          'Samachar',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),

        actions: [
          PopupMenuButton<filterList>(
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (filterList item) {
              if (filterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }

              if (filterList.aryNews.name == item.name) {
                name = 'ary-news';
              }

              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder:
                (context) => <PopupMenuEntry<filterList>>[
                  PopupMenuItem<filterList>(
                    value: filterList.bbcNews,
                    child: Text('BBC News'),
                  ),
                  PopupMenuItem<filterList>(
                    value: filterList.bbcNews,
                    child: Text('Ary News'),
                  ),
                ],
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,

            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsHeadlines(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => NewsDetailScreen(
                                    newsDate:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .publishedAt
                                            .toString(),
                                    newsTitle:
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                    newsImage:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .urlToImage
                                            .toString(),
                                    author:
                                        snapshot.data!.articles![index].author
                                            .toString(),
                                    description:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .description
                                            .toString(),
                                    content:
                                        snapshot.data!.articles![index].content
                                            .toString(),
                                    source:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .source!
                                            .name
                                            .toString(),
                                  ),
                            ),
                          );
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * .02,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        snapshot
                                            .data!
                                            .articles![index]
                                            .urlToImage
                                            .toString(),
                                    fit: BoxFit.cover,
                                    placeholder:
                                        (context, url) => SpinKitFadingCircle(
                                          size: 50,
                                          color: Colors.blue,
                                        ),
                                    errorWidget:
                                        (context, url, error) => Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    height: height * .22,
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!
                                                .articles![index]
                                                .title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoryNewsModel>(
              future: newsViewModel.fetchCategories('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(size: 50, color: Colors.blue),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                    snapshot.data!.articles![index].urlToImage
                                        .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder:
                                    (context, url) => SpinKitFadingCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                errorWidget:
                                    (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: height * .18,
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data!.articles![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Spacer(),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot
                                              .data!
                                              .articles![index]
                                              .source!
                                              .name
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 13,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
