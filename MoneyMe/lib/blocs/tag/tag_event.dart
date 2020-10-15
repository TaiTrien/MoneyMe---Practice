part of 'tag_bloc.dart';

@immutable
abstract class TagEvent {
  final dynamic payload;

  TagEvent({this.payload});
}

class LoadingTagsData extends TagEvent {
  LoadingTagsData(List<Tag> tagsList) : super(payload: tagsList);
}

class SelectTag extends TagEvent {
  SelectTag(Tag tag) : super(payload: tag);
}
