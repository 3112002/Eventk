import 'package:dio/dio.dart';
import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/errors/errorModel.dart';
import 'package:eventk/Core/errors/exceptions.dart';
import 'package:eventk/Core/utils/End_Point.dart';
import 'package:eventk/Features/Home/Data/model/organizationModel.dart';

/*Yara❤️*/
class GetOrganizationService {
  final Dio dio;
  GetOrganizationService(this.dio);
  Future<List<OrganizationModel>> GetOrganizatoin(bool? isFollowing) async {
    try {
      String exit = '?IsFollowing=$isFollowing';
      final token = getIt<CacheHelper>().getData(key: 'token');
      if (token == null) {
        isFollowing = null;
        exit = '';
      }
      Response response = await dio.get(
        EndPoint.baseUrlOrganization + 'get-organizations' + '$exit',
        options: Options(
          headers: {
            'accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! >= 200 && status < 300,
        ),
      );
      List<dynamic> jsonData = response.data;
      List<OrganizationModel> organizationList = [];

      for (var item in jsonData) {
        OrganizationModel organizationModel = OrganizationModel.fromJson(item);
        organizationList.add(organizationModel);
      }
      return organizationList;
    } on DioException catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.response!.data);
      final String errorMessage =
          errorModel.message ?? 'oops ,there was an error , try later !';
      throw CustomExceptions(errorMessage);
    } catch (e) {
      throw CustomExceptions((e.toString()));
    }
  }
}
