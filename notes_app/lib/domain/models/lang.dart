import 'package:flutter/material.dart';
import 'package:notes_app/presentation/widgets/AppConstant.dart';

class Lang {
  int id;
  String country;
  Locale contryCode;
  Lang(this.id, this.country, this.contryCode);
  static List<Lang> getLang() {
    return <Lang>[
      Lang(1, 'turkish', AppConstant.TR_LOCALE),
      Lang(2, 'arabic', AppConstant.AR_LOCALE),
      Lang(3, 'english', AppConstant.EN_LOCALE),
      Lang(4, 'germany', AppConstant.DE_LOCALE),
      Lang(5, 'french', AppConstant.FR_LOCALE),
      Lang(6, 'russia', AppConstant.RU_LOCALE),
    ];
  }
}
