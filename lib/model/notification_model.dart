import 'package:meta/meta.dart';
import 'models.dart';

class UserNotification {
  final User user;
  final String interaction;
  final Post post;
  bool isViewed;

  UserNotification({
    @required this.user,
    @required this.interaction,
    @required this.post,
    this.isViewed = false,
  });
}
