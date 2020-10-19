import 'dart:async';

import 'package:MoneyMe/models/tag.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(TagInitialState());

  @override
  Stream<TagState> mapEventToState(TagEvent event) async* {
    if (event is LoadingTagsData) {
      yield UpdateState(state, tagsList: event.payload);
    } else if (event is SelectTag) {
      yield UpdateState(state, selectedTag: event.payload);
    } else if (event is ResetSelectedTag) {
      yield ResetState(state, selectedTag: event.payload);
    } else if (event is SumExpense) {
      yield UpdateState(state, totalExpense: event.payload);
    }
  }
}