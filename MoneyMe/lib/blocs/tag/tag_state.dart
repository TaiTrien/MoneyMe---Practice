part of 'tag_bloc.dart';

@immutable
abstract class TagState {
  final List<Tag> tagsList;

  TagState({this.tagsList});
}

class TagInitialState extends TagState {
  TagInitialState() : super(tagsList: null);
}

class LoadingState extends TagState {
  LoadingState(TagState oldState, {List<Tag> tagsList}) : super(tagsList: tagsList ?? oldState.tagsList);
}
