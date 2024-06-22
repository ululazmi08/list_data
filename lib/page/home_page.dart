import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/typography.dart';
import 'package:test_viapulsa/controller/home_controller.dart';
import 'package:test_viapulsa/page/widget/card_list.dart';
import 'package:test_viapulsa/page/widget/dialog_add_list.dart';
import 'package:test_viapulsa/page/widget/search.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      appBar: AppBar(
        title: Text(
          'Data List',
          style: TStyle.title.copyWith(
            color: kColorWhite,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: kColorBlue,
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: controller.enablePullDown.value,
          controller: controller.refreshController,
          onRefresh: () {
            // await Future.delayed(const Duration(milliseconds: 1000));
            controller.refreshController.refreshCompleted();
            controller.getListData(reset: true);
          },
          onLoading: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            controller.getListData();
            controller.refreshController.loadComplete();
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Search(),
                Obx(
                  () => controller.loadingDataList.value
                      ? controller.sortDataList.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: kColorYellow),
                                  color: kColorBgAlert),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    'Data Tidak Ada',
                                    style: TStyle.title,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.sortDataList.length,
                              itemBuilder: (context, index) {
                                var data = controller.sortDataList[index];
                                return Column(
                                  children: [
                                    CardList(
                                      data: data,
                                      btnEdit: () {
                                        controller.editListData(data.id.toString());
                                      },
                                      btnDelete: () {
                                        controller.deleteListData(data.id.toString());
                                      },
                                      title: controller.titleController.value,
                                      desc: controller.descController.value,
                                      searchCondition: controller.searchBool.value,
                                      keyForm: controller.formKey,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              },
                            )
                      : SizedBox(
                          height: Get.height / 2,
                          width: Get.width,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: kColorBlue,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: kColorBlue,
        onPressed: () {
          Get.dialog(
            barrierDismissible: false,
            Dialog(
              backgroundColor: kColorWhite,
              child: DialogAddList(
                onTap: () {
                  controller.addListData();
                },
                title: 'Tambahkan Data Baru',
                textBtn: 'Kirim',
                ctrTitle: controller.titleController.value,
                ctrDesc: controller.descController.value,
                keyForm: controller.formKey,
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: kColorWhite),
      ),
    );
  }
}
