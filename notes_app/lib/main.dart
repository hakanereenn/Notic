import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/domain/models/tagmodal.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/presentation/providers/add_note_provider.dart';
import 'package:notes_app/presentation/providers/app_provider.dart';
import 'package:notes_app/presentation/providers/main_provider.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:notes_app/presentation/screens/add_note.dart';
import 'package:notes_app/presentation/screens/edit_note.dart';
import 'package:notes_app/presentation/screens/read_note.dart';
import 'package:notes_app/presentation/screens/settings.dart';
import 'package:notes_app/presentation/widgets/listing_note/tag_detail.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'presentation/widgets/AppConstant.dart';
import 'presentation/screens/listing_note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NoteModalAdapter());
  Hive.registerAdapter(TagModalAdapter());
  await Hive.openBox<TagModal>("tagBox");
  await Hive.openBox<NoteModal>("noteBox");
  runApp(EasyLocalization(
    supportedLocales: [
      AppConstant.TR_LOCALE,
      AppConstant.EN_LOCALE,
      AppConstant.AR_LOCALE,
      AppConstant.RU_LOCALE,
      AppConstant.FR_LOCALE,
      AppConstant.DE_LOCALE,
    ],
    path: AppConstant.LANG_PATH,
    fallbackLocale: AppConstant.TR_LOCALE,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(
          create: (_) => AddNoteProvider(),
        ),
        ChangeNotifierProvider<MainProvider>(
          create: (context) => MainProvider()..initData(),
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (BuildContext context, AppProvider provider, Widget child) =>
            MaterialApp(
          key: provider.key,
          navigatorKey: provider.navigatorKey,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: provider.theme,
          darkTheme: AppThemeConstant.darkTheme,
          initialRoute: AppRoutes.home,
          routes: {
            AppRoutes.home: (_) => ListingNote(),
            AppRoutes.addNote: (_) => AddNote(),
            AppRoutes.readNote: (_) => ReadNote(),
            AppRoutes.setting: (_) => Settings(),
            AppRoutes.editNote: (_) => EditNote(),
            AppRoutes.detailTagList: (_) => TagDetail(),
          },
        ),
      ),
    );
  }
}
