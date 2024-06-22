import 'package:flutter/material.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/typography.dart';
import 'package:test_viapulsa/models/list_data_models.dart';

class DialogDelete extends StatelessWidget {
  DialogDelete({required this.data, required this.btnNo, required this.btnYes,Key? key}) : super(key: key);

  ListData data;
  VoidCallback btnNo;
  VoidCallback btnYes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Yakin menghapus Data List ini ?',
            style: TStyle.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            data.title,
            style: TStyle.desc,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.end,
            children: [
              MaterialButton(
                onPressed: btnYes,
                // () async {
                //   await controller.deleteListData(
                //       data.id.toString());
                // },
                color: kColorBlue,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(4)),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Ya',
                  style: TStyle.title.copyWith(
                      fontSize: 15,
                      color: kColorWhite),
                ),
              ),
              const SizedBox(width: 16),
              MaterialButton(
                onPressed: btnNo,
                //     () {
                //   Get.back();
                // },
                color: kColorRed,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Tidak',
                  style: TStyle.title.copyWith(
                      fontSize: 15,
                      color: kColorWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
