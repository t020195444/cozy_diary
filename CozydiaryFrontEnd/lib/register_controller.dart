import 'package:get/get.dart';

class RegisterController extends GetxController {
  final RegisterController repository;
  RegisterController(this.repository);

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
