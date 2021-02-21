import 'package:anime_twist_flut/models/TwistModel.dart';
import 'package:anime_twist_flut/models/kitsu/KitsuModel.dart';
import 'package:anime_twist_flut/pages/discover_page/DiscoverAnimeTile.dart';
import 'package:anime_twist_flut/pages/discover_page/LoadingAnimeTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class KitsuAnimeRow extends StatefulWidget {
  KitsuAnimeRow({Key key, @required this.futureProvider}) : super(key: key);

  final FutureProvider<Map<TwistModel, KitsuModel>> futureProvider;

  @override
  _KitsuAnimeRowState createState() => _KitsuAnimeRowState();
}

class _KitsuAnimeRowState extends State<KitsuAnimeRow>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (context, watch, child) {
        return watch(widget.futureProvider).when(
          data: (data) {
            return Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.keys.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: DiscoverAnimeTile(
                      kitsuModel: data.values.elementAt(index),
                      twistModel: data.keys.elementAt(index),
                    ),
                  );
                },
              ),
            );
          },
          loading: () {
            return Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: LoadingAnimeTile(),
                  );
                },
              ),
            );
          },
          error: (e, s) => Container(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
