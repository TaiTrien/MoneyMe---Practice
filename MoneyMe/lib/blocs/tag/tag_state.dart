part of 'tag_bloc.dart';

@immutable
abstract class TagState {
  final List<Tag> tagsList;
  final Tag selectedTag;
  final int totalExpense;

  TagState({this.tagsList, this.selectedTag, this.totalExpense});
}

class TagInitialState extends TagState {
  TagInitialState() : super(tagsList: null, selectedTag: null, totalExpense: 0);
}

class UpdateState extends TagState {
  UpdateState(
    TagState oldState, {
    List<Tag> tagsList,
    Tag selectedTag,
    int totalExpense,
  }) : super(
          totalExpense: totalExpense ?? oldState.totalExpense,
          tagsList: tagsList ?? oldState.tagsList,
          selectedTag: selectedTag ?? oldState.selectedTag,
        );
}

class ResetState extends TagState {
  ResetState(
    TagState oldState, {
    List<Tag> tagsList,
    Tag selectedTag,
    int totalExpense,
  }) : super(
          totalExpense: totalExpense ?? oldState.totalExpense,
          tagsList: tagsList ?? oldState.tagsList,
          selectedTag: selectedTag,
        );
}
