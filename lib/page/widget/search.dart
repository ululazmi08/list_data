import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/component.dart';
import 'package:test_viapulsa/controller/home_controller.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchBool.value
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: (value) {
                  controller.search(value);
                },
                controller: controller.searchController.value,
                decoration: kDecorationForm.copyWith(
                  hintText: 'Cari data...',
                  suffixIcon: InkWell(
                    onTap: () {
                      controller.searchBool.value = !controller.searchBool.value;
                      if (!controller.searchBool.value) {
                        controller.searchController.value.clear();
                        controller.sortDataList.assignAll(controller.dataList);
                      }
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: kColorNeutral80,
                      size: 16,
                    ),
                  ),
                ),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    controller.searchBool.value =
                        !controller.searchBool.value;
                    controller.getListData();
                  },
                  icon: const Icon(Icons.search_rounded),
                ),
              ],
            ),
    );
  }
}
