//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';

import 'package:lib_network_grid/network_grid_card.dart';

import 'details_bloc.dart';


class DetailsScreenStyle {
  const DetailsScreenStyle({@required this.appBarColor, @required this.appBarHeight, @required this.backgroundColor});
  final Color appBarColor;
  final double appBarHeight;
  final Color backgroundColor;
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, @required this.style, @required this.bloc, @required this.serie}) : super(key: key);

  static const String route = '/details';

  final NetworkGridDataWrapper serie;
  final DetailsScreenStyle style;
  final DetailsScreenBLoC bloc;

  Widget homeButton(final BuildContext context) {
    return BackButton(
      color: Color(0xffffffff),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget buildCreatorList() {
    return StreamBuilder(
      stream: bloc.reloadSerieInfoStream,
      builder: (final BuildContext c, final AsyncSnapshot<bool> snp) {
        final creators = bloc.creators;
        return ListView.builder(
          itemBuilder: (final BuildContext context, final int index) {
            final creator = creators[index];
            return Text(creator.title ?? 'Unknown');
          },
          itemCount: creators.length,
        );
      }
    );
  }

  @override
  Widget build(final BuildContext context) {
    bloc.udpateInfo(serie.id);

    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(style.appBarHeight), // here the desired height
        child: AppBar(
          backgroundColor: style.appBarColor,
          title: Text('Creators from: ${serie.title}', overflow: TextOverflow.ellipsis),
          leading: homeButton(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: style.backgroundColor,
        child: buildCreatorList(),
      )
    );
  }
}