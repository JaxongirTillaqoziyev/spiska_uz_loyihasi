import 'package:url_launcher/url_launcher.dart';

import '../../service/utils.dart';
class MapUtils{
  MapUtils._();
  static Future<void> openMap(double latitude,longtitude) async{
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longtitude';
    if(await canLaunch(googleUrl)){
      await launch(googleUrl);
    }
    else {
      Utils.showToast("google xarita ochilmadi");
    }
  }
}
