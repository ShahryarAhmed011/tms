import 'package:tms/core/base/base_repository.dart';
import 'package:tms/models/project.dart';

abstract class HomeRepository extends BaseRepository {

  Future<List<Project>> getProjects();

  /*Future<ResponseModel> updateProfile({
    required String businessName,
    required String businessDescription,
    required String businessEmail,
    required String businessPhone,
    required String businessAddress,
    required String postalCode,
    required String countryId,
    required String stateId,
    required String cityId,
    required String language,
    required String currency,
  });*/

}

