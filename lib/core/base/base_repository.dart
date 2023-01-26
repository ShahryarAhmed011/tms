import 'package:tms/db/app_database.dart';

class BaseRepository {
  final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();
}
