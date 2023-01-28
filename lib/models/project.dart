import 'package:floor/floor.dart';


///Project entity class
@entity
class Project {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  String? description;
  int? dateTime;

  Project({this.id, required this.name, required this.description, required this.dateTime,});
}
