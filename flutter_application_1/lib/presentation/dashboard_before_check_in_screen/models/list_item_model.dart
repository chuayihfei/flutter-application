class ListItemModel {
  ListItemModel({this.name, this.id}) {
    name = name ?? "";
    id = id ?? "";
  }

  String? name;
  String? id;
}
