import 'dart:async';
import 'package:excercise_2/models/new_transaction.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:excercise_2/blocs/newBloc/new_bloc.dart';
import 'package:excercise_2/blocs/newBloc/new_event.dart';
import 'package:excercise_2/blocs/newBloc/new_state.dart';
import 'package:excercise_2/constants/color.dart';
import 'package:excercise_2/constants/vector.dart';
import 'package:excercise_2/models/new_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/image.dart';
import '../detail/new_detail_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scrollController = ScrollController();
  List<NewTransaction> newTransaction = [];
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          context.read<ListNewBloc>().add(GetNewListEvent());
          BlocProvider.of<ListNewBloc>(context).add(GetNewListEvent());
        }
      }
    });
    super.initState();
  }

  String convertDate(String date) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd, yyyy');
    return outputFormat.format(inputDate);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(() {
        if (_scrollController.position.atEdge) {
          if (_scrollController.position.pixels != 0) {
            context.read<ListNewBloc>().add(GetNewListEvent());
            BlocProvider.of<ListNewBloc>(context).add(GetNewListEvent());
          }
        }
      })
      ..dispose();
    Hive.box('NewTransaction').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ListNewBloc>(context).add(GetNewListEvent());
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1],
                  transform: GradientRotation(90 * 3.14 / 180),
                  colors: <Color>[Color(0xff18DAB8), Color(0xff1D1A61)])),
        ),
        toolbarHeight: 100,
        backgroundColor: Color(0xff18DAB8),
        leading: Container(
          height: 24,
          width: 24,
          padding: EdgeInsets.only(top: 30, bottom: 30, left: 10),
          decoration:
              BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () {},
                  focusColor: AppColors.white,
                  hoverColor: AppColors.white,
                  child: Ink(child: Icon(Icons.menu)))),
        ),
        centerTitle: true,
        title: Text('My News',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 16),
                child: Text('News',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1D1A61))),
              ),
              SizedBox(height: 24 - 8),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    height: 800 - 200,
                    child: BlocBuilder<ListNewBloc, NewState>(
                        builder: (context, state) {
                      if (state is NewLoading && state.isFirstFetch) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.grey700,
                        ));
                      }
                      List<NewModel> newList = [];
                      bool isLoading = false;
                      if (state is NewLoading) {
                        newList = state.oldNewList;
                        isLoading = true;
                      } else if (state is NewLoaded) {
                        newList = state.newList;
                      }
                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 0.5,
                                color: Color(0xFF1D1A61).withOpacity(0.3),
                              ),
                            );
                          },
                          itemCount: newList.length + (isLoading ? 1 : 0),
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            print(newList.length);
                            if (index >= newList.length) {
                              return Container(
                                height: 24,
                                width: 24,
                                child: FittedBox(
                                  child: CircularProgressIndicator(
                                    color: AppColors.grey700,
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(bottom: 8, top: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Column(children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NewDetailScreen()));
                                      },
                                      hoverColor: AppColors.grey500,
                                      focusColor: AppColors.grey500,
                                      splashColor: AppColors.grey500,
                                      child: Ink(
                                        padding: EdgeInsets.all(4),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(children: [
                                              Container(
                                                height: 100,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    color: AppColors.grey500,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  child: Image.asset(
                                                    AppImages.imageSoccer,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(6.24),
                                                margin: EdgeInsets.only(
                                                    top: 70, left: 129),
                                                decoration: BoxDecoration(
                                                    color: AppColors.orange,
                                                    shape: BoxShape.circle),
                                                child: SvgPicture.asset(
                                                    AppVectors.document),
                                              )
                                            ]),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                        newList[index].title,
                                                        maxLines: 3,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColors
                                                                .blue)),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                        newList[index].summary,
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .blue)),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: 180,
                                                    child: Text(
                                                        convertDate(
                                                            newList[index]
                                                                .modifiedAt),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'OpenSans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .blue)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              );
                            }
                          });
                    } // });
                        )),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 35,
        width: 35,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color(0xff1D1A61),
            hoverColor: AppColors.white,
            child: Container(
                height: 24,
                width: 24,
                child: FittedBox(child: SvgPicture.asset(AppVectors.arrowUp))),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
