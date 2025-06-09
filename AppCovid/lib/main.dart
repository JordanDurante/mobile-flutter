import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/android/appcovid.dart';

void main() {
  if(Platform.isAndroid) {
    debugPrint('app no android');
    runApp(Appcovid());
  }
  if(Platform.isIOS) {
    debugPrint('app no IOS');
  }

}




