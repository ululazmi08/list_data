import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/models/list_data_models.dart';
import 'package:test_viapulsa/services/home_services.dart';

class HomeController extends GetxController {
  var loadingDataList = false.obs;
  var loadingDeleteList = false.obs;
  var dataList = <ListData>[].obs;
  var sortDataList = <ListData>[].obs;
  var searchBool = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController().obs;
  var descController = TextEditingController().obs;
  var searchController = TextEditingController().obs;

  var enablePullDown = true.obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    super.onInit();
    getListData();
  }

  void getListData({bool reset = false}) async {
    if (reset) {
      sortDataList.clear();
      enablePullDown.value = true;
    }
    loadingDataList.value = false;
    try {
      List data = await HomeServices.dataList();
      if (data.isNotEmpty) {
        dataList.value = data.map((e) => ListData.fromJson(e)).toList();
        sortDataList.assignAll(dataList);
      } else {
        sortDataList.clear();
      }
    } catch (e) {
      print('error getListData : $e');
    } finally {
      loadingDataList.value = true;
    }
  }

  void addListData() async {
    if (formKey.currentState!.validate()) {
      Get.back();
      Get.dialog(
        barrierColor: Colors.transparent,
        const Center(
          child: CircularProgressIndicator(
            color: kColorBlue,
          ),
        ),
      );
      try {
        var data = await HomeServices.addList(
            titleController.value.text, descController.value.text);
        if (data != null) {
          titleController.value.clear();
          descController.value.clear();
          sortDataList.add(ListData.fromJson(data));
          print('Successed addListData');
          Get.back();
        }
      } catch (e) {
        print('Error addListData : $e');
        Get.back();
      }
    }
  }

  void editListData(String id) async {
    if (formKey.currentState!.validate()) {
      Get.back();
      Get.dialog(
        barrierColor: Colors.transparent,
        const Center(
          child: CircularProgressIndicator(
            color: kColorBlue,
          ),
        ),
      );
      try {
        var data = await HomeServices.editList(
            titleController.value.text, descController.value.text, id);
        if (data != null) {
          titleController.value.clear();
          descController.value.clear();
          int index =
              sortDataList.indexWhere((item) => item.id == int.parse(id));
          if (index != -1) {
            sortDataList[index] = ListData.fromJson(data);
          }
          // getListData();
          print('Successed editListData');
          Get.back();
        }
      } catch (e) {
        print('Error editListData : $e');
        Get.back();
      }
    }
  }

  void deleteListData(String id) async {
    Get.back();
    Get.dialog(
      barrierColor: Colors.transparent,
      const Center(
        child: CircularProgressIndicator(
          color: kColorBlue,
        ),
      ),
    );
    try {
      var data = await HomeServices.deleteList(id);
      if (data != null && data['status'] == 'data deleted') {
        dataList.removeWhere((item) => item.id == int.parse(id));
        sortDataList.removeWhere((item) => item.id == int.parse(id));
        Get.back();
      }
    } catch (e) {
      print('error deleteListData : $e');
      Get.back();
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      sortDataList.assignAll(dataList);
    } else {
      var result = dataList
          .where(
            (user) =>
                user.title.toLowerCase().contains(query.toLowerCase()) ||
                user.description.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      sortDataList.assignAll(result);
    }
  }
}
