/// This class is used in the [list_item_widget] screen.
class BeforeSubstationListModel {
  BeforeSubstationListModel({
    this.name,
    this.id,
  }) {
    name = name ?? "";
    id = id ?? "";
  }

  String? name;

  String? id;
}
