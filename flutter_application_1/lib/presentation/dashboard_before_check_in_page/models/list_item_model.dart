/// This class is used in the [list_item_widget] screen.
class ListItemModel {
  ListItemModel({
    this.concourse,
    this.id,
  }) {
    concourse = concourse ?? "Concourse";
    id = id ?? "";
  }

  String? concourse;

  String? id;
}
