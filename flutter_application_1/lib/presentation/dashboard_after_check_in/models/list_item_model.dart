/// This class is used in the [list1_item_widget] screen.
class List1ItemModel {
  List1ItemModel({
    this.concourse,
    this.id,
  }) {
    concourse = concourse ?? "Concourse";
    id = id ?? "";
  }

  String? concourse;

  String? id;
}
