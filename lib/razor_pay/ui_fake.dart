import 'dart:ui' as ui;

// ignore: camel_case_types
class  {
  static registerViewFactory(String viewId, dynamic cb) {
    ui.platformViewRegistry.registerViewFactory(viewId, cb);
  }
}
