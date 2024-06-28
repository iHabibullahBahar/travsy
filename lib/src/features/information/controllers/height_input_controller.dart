import 'package:get/get.dart';

class HeightInputController extends GetxController {
  //Write from 50 to 250
  List<int> heightInCmList = List.generate(150, (index) => 50 + index);
  @override
  void onInit() {
    super.onInit();
  }
}
