import 'package:rxdart/rxdart.dart';

class ViewController {
  final pageController = BehaviorSubject<int?>();
  Function(int?) get setBaseListStream => pageController.sink.add;

  Stream<int?> get getBaseListStream => pageController.stream;
}

ViewController viewController = ViewController();
