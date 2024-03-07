import 'package:agencies_app/models/event_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageEventsNotifier extends StateNotifier<List<EventList>> {
  ManageEventsNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<EventList> list) {
    state = list;
  }

  void removeAt({required String id}) {
    state = state
        .where(
          (element) => element.eventId != id,
        )
        .toList();
  }
}

final manageEventsProvider =
    StateNotifierProvider<ManageEventsNotifier, List<EventList>>(
        (reff) => ManageEventsNotifier(ref: reff));
