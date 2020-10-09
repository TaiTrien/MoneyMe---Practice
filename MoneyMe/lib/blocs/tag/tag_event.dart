part of 'tag_bloc.dart';

@immutable
abstract class TagEvent {
  final dynamic payload;

  TagEvent({this.payload});
}

class LoadingTagsData extends TagEvent {
  LoadingTagsData(List<Tag> tagsList) : super(payload: tagsList);
}
