import 'package:meta/meta.dart';
import 'models.dart';

class ExploreCard {
  final User user;
  final String imageUrl;
  final String title;
  final bool isViewed;

  const ExploreCard({
    @required this.user,
    @required this.imageUrl,
    @required this.title = "hello?",
    this.isViewed = false,
  });
}
