import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:developer';
import 'package:flutter_archfolio/config/palette.dart';
import 'package:flutter_archfolio/model/models.dart';
import 'package:flutter_archfolio/screens/view_post_screen.dart';
import 'package:flutter_archfolio/widgets/widgets.dart';

class ExploreCards extends StatelessWidget {
  final List<ExploreCard> exploreCards;
  final String title;
  final bool seeMore;

  const ExploreCards({
    Key key,
    @required this.exploreCards,
    @required this.title,
    this.seeMore = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.cardTheme,
      child: Container(
        height: 180.0,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 8.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: exploreCards.length,
          itemBuilder: (BuildContext context, int index) {
            final ExploreCard card = exploreCards[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
              child: InkWell(
                  onTap: () {
                    print('post $index');
                  },
                  child: _ExploreCard(card: card)),
            );
          },
        ),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final ExploreCard card;

  const _ExploreCard({
    Key key,
    @required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            imageUrl: card.imageUrl,
            height: double.infinity,
            width: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: double.infinity,
          width: 150.0,
          decoration: BoxDecoration(
            gradient: Palette.cardGradient,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
          bottom: 20.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            card.title,
            style: const TextStyle(
              fontSize: 18.0,
              color: Palette.postTheme,
              fontWeight: FontWeight.normal,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            card.user.name,
            style: const TextStyle(
              fontSize: 12.0,
              color: Palette.postTheme,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
