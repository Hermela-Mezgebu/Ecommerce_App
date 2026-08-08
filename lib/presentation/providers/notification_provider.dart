import 'package:flutter_riverpod/flutter_riverpod.dart';


class NotificationNotifier extends Notifier<int> {

  @override
  int build() {
    return 0;
  }


  void addNotification() {
    state++;
  }


  void clearNotifications() {
    state = 0;
  }

}


final notificationProvider =
    NotifierProvider<NotificationNotifier, int>(
      NotificationNotifier.new,
    );