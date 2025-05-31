import 'package:get/get.dart';
import 'package:tatify_app/view/splash/model/get_banner_model.dart';

import '../../../data/api_client/bace_client.dart';
import '../../../data/api_client/end_point.dart';

class SplashController extends GetxController{
  var isLoading = false.obs;

  var bannerModel = GetBannerModel().obs;
  var bannerList = <BannerList>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanner();
  }

  Future<void> getBanner()async{
    isLoading(true);
   try{
     Map<String, String> headers = {
       'Content-Type': 'application/json',
     };

     dynamic responseBody = await BaseClient.handleResponse(
       await BaseClient.getRequest(
         api: EndPoint.getBannerURL,
         headers: headers,
       ),
     );

     if(responseBody != null && responseBody['success'] == true){
       bannerList.clear();
       bannerModel.value = GetBannerModel.fromJson(responseBody);
       if(bannerModel.value.data != null){
         bannerList.value = bannerModel.value.data?.data ?? [];
       }
     }
   }catch(e){
     print('Banner error $e');
   }finally{
     isLoading(false);
   }
  }
}