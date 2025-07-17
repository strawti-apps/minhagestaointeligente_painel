import 'package:get/get.dart';

mixin LoaderManager on GetxController {
  bool isLoading = false;
  bool isLoadingDeleting = false;
  bool isLoadingEditing = false;
  bool isLoadingCreating = false;

  bool isLoadingAux = false;
  bool isLoadingRefresh = false;

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  void changeLoadingCreating(bool newValue) {
    isLoadingCreating = newValue;
    update();
  }

  void changeLoadingEditing(bool newValue) {
    isLoadingEditing = newValue;
    update();
  }

  void changeLoadingDeleting(bool newValue) {
    isLoadingDeleting = newValue;
    update();
  }

  void changeLoadingAux(bool newValue) {
    isLoadingAux = newValue;
    update();
  }

  void changeLoadingRefresh(bool newValue) {
    isLoadingRefresh = newValue;
    update();
  }
}