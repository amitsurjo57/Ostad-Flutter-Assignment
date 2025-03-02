import 'package:e_commerce_project/Networks/network_caller.dart';
import 'package:e_commerce_project/Networks/network_response.dart';
import 'package:e_commerce_project/Networks/network_utils.dart';

class ReadProfile {
  Future<bool> isComplete(String token) async {
    final NetworkResponse response = await NetworkCaller().getRequest(
      NetworkUtils.readProfile,
      token: token,
    );

    if (response.responseData['data'] == null) {
      return false;
    } else {
      return true;
    }
  }
}
