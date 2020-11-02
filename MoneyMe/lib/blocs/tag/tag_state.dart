part of 'tag_bloc.dart';

@immutable
abstract class TagState {
  final List<Tag> tagsList;
  final Tag selectedTag;
  TagState({this.tagsList, this.selectedTag});

  getChildTagsList() {
    var childTagsList = List<Tag>();

    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;

      if (parentID != '0') {
        childTagsList.add(tagsList[i]);
      }
    }
    return childTagsList;
  }

  Map<int, Map<String, dynamic>> get revenues {
    var childTagsList = getChildTagsList();
    Map<int, Map<String, dynamic>> revenueMap = Map<int, Map<String, dynamic>>();
    int revenueIndex = 0;

    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;
      if (parentID == '0') {
        String tagID = tagsList[i].tagID;
        if (tagsList[i].type == '1') {
          revenueMap[revenueIndex] = {
            'parent': tagsList[i],
            'children': childTagsList.where((tag) => (tag.parentID == tagID)).toList(),
          };
          revenueIndex++;
        }
      }
    }
    return revenueMap;
  }

  Map<int, Map<String, dynamic>> get expenses {
    var childTagsList = getChildTagsList();
    Map<int, Map<String, dynamic>> expenseMap = Map<int, Map<String, dynamic>>();
    int expenseIndex = 0;
    for (int i = 0; i < tagsList.length; i++) {
      String parentID = tagsList[i].parentID;

      if (parentID == '0') {
        String tagID = tagsList[i].tagID;
        if (tagsList[i].type == '2') {
          expenseMap[expenseIndex] = {
            'parent': tagsList[i],
            'children': childTagsList.where((tag) => (tag.parentID == tagID)).toList(),
          };
          expenseIndex++;
        }
      }
    }
    return expenseMap;
  }
}

class TagInitialState extends TagState {
  TagInitialState()
      : super(
          tagsList: null,
          selectedTag: null,
        );
  Map<int, Map<String, dynamic>> get revenues => null;
  Map<int, Map<String, dynamic>> get expenses => null;
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

class ResetState extends TagState {
  ResetState(
    TagState oldState, {
    List<Tag> tagsList,
    Tag selectedTag,
  }) : super(
          tagsList: tagsList ?? oldState.tagsList,
          selectedTag: selectedTag,
        );
}
