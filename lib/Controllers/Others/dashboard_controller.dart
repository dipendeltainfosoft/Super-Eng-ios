import 'package:get/get.dart';

class DashboardController extends GetxController{
  var profileImgUrl = ''.obs;

  setProileImage(String val){
    print('setProileImage Fired');
    profileImgUrl.value = val;
  }

  @override
  void dispose() {
    super.dispose();
  }
}


