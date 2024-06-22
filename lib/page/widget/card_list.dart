import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/typography.dart';
import 'package:test_viapulsa/models/list_data_models.dart';
import 'package:test_viapulsa/page/widget/dialog_add_list.dart';
import 'package:test_viapulsa/page/widget/dialog_delete.dart';

class CardList extends StatelessWidget {
  CardList({
    required this.data,
    required this.btnEdit,
    required this.btnDelete,
    required this.title,
    required this.desc,
    required this.searchCondition,
    required this.keyForm,
    Key? key,
  }) : super(key: key);

  ListData data;
  VoidCallback btnEdit;
  VoidCallback btnDelete;
  TextEditingController title;
  TextEditingController desc;
  bool searchCondition;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kColorMainLine),
          color: kColorWhite),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TStyle.title,
                  ),
                ),
              ),
              searchCondition
                  ? const SizedBox()
                  : Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            title.text = data.title;
                            desc.text = data.description;
                            Get.dialog(
                              barrierDismissible: false,
                              Dialog(
                                backgroundColor: kColorWhite,
                                child: DialogAddList(
                                  onTap: btnEdit,
                                  title: 'Edit Data',
                                  textBtn: 'Edit',
                                  ctrDesc: desc,
                                  ctrTitle: title,
                                  keyForm: keyForm,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_rounded,
                            color: kColorBlue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.dialog(
                              Dialog(
                                backgroundColor: kColorWhite,
                                child: DialogDelete(
                                  data: data,
                                  btnNo: () {
                                    Get.back();
                                  },
                                  btnYes: btnDelete,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: kColorRed,
                          ),
                        )
                      ],
                    ),
            ],
          ),
          const Divider(
            color: kColorMainLine,
            thickness: 1,
            height: 0,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deksripsi',
                  style: TStyle.desc.copyWith(color: kColorNeutral80),
                ),
                Text(
                  data.description,
                  style: TStyle.desc,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
