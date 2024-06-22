import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_viapulsa/constant/colors.dart';
import 'package:test_viapulsa/constant/component.dart';
import 'package:test_viapulsa/constant/typography.dart';

class DialogAddList extends StatelessWidget {
  DialogAddList({
    required this.onTap,
    required this.title,
    required this.textBtn,
    required this.ctrTitle,
    required this.ctrDesc,
    required this.keyForm,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final String textBtn;
  TextEditingController ctrTitle;
  TextEditingController ctrDesc;
  final GlobalKey<FormState> keyForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Form(
        key: keyForm,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TStyle.title,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: kColorNeutral10,
                    ),
                  )
                ],
              ),
              Text('Judul', style: TStyle.title),
              TextFormField(
                controller: ctrTitle,
                decoration: kDecorationForm.copyWith(hintText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text('Deskripsi', style: TStyle.title),
              TextFormField(
                controller: ctrDesc,
                decoration: kDecorationForm.copyWith(hintText: 'Deskripsi'),
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: onTap,
                      color: kColorBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Text(
                        textBtn,
                        style: TStyle.title
                            .copyWith(fontSize: 15, color: kColorWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
