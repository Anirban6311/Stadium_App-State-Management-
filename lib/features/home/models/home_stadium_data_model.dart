class StadiumDataModel {
  final String name;
  final String location;
  final int capacity;
  final int openedYear;
  final String description;
  final String? imageUrl;

  StadiumDataModel(
      {required this.name,
      required this.location,
      required this.capacity,
      required this.openedYear,
      required this.description,
      this.imageUrl});
}
