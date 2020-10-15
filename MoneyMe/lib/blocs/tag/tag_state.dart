part of 'tag_bloc.dart';

@immutable
abstract class TagState {
  final List<Tag> tagsList;
  final Tag selectedTag;

  TagState({this.tagsList, this.selectedTag});
}

class TagInitialState extends TagState {
  TagInitialState() : super(tagsList: null, selectedTag: null);
}

class UpdateState extends TagState {
  UpdateState(
    TagState oldState, {
    List<Tag> tagsList,
    Tag selectedTag,
  }) : super(
          tagsList: tagsList ?? oldState.tagsList,
          selectedTag: selectedTag ?? oldState.selectedTag,
        );
}
