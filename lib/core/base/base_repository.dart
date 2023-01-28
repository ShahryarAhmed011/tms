import 'package:tms/db/app_database.dart';

/// A base repository class that initializes a database instance.
class BaseRepository {
  /// The instance of the database
  final database =  $FloorAppDatabase.databaseBuilder('tms_database.db').build();
}

