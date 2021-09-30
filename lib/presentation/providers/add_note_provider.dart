import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/domain/models/tagmodal.dart';

class AddNoteProvider extends ChangeNotifier {
  String _title;
  String get title => _title;
  String _content;
  String get content => _content;
  String _tagName = "#";
  String get tagName => _tagName;
  bool _isArchive;
  bool get isArchive => _isArchive;
  bool _isImportant;
  bool get isImportant => _isImportant;
  DateTime _dateTime;
  DateTime get dateTime => _dateTime;
  int _color = 0;
  int get color => _color;
  TagModal _tagModal;
  TagModal get tagModal => _tagModal;
  bool _addStatus = false;
  bool get addStatus => _addStatus;
  Future<void> setArchive(bool archive) async {
    _isArchive = archive;
    notifyListeners();
  }

  void setTagModal(TagModal tag) {
    _tagModal = tag;
    notifyListeners();
  }

  void setAddStatus(bool s) {
    _addStatus = s;

    notifyListeners();
  }

  Future<void> setImportant(bool important) async {
    _isImportant = important;
    notifyListeners();
  }

  void setDate() {
    DateTime dateTime = DateTime.now();
    DateTime dateFormat =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(dateTime));
    _dateTime = dateFormat;
    notifyListeners();
  }

  setDateAndBool() {
    DateTime dateTime = DateTime.now();
    bool isArchived = false;
    bool isImportant = false;
    DateTime dateFormat =
        DateTime.parse(DateFormat('yyyy-MM-dd HH:mm').format(dateTime));

    _isArchive = isArchived;
    _isImportant = isImportant;
    _dateTime = dateFormat;
    notifyListeners();
  }

  void setTitle(String text) {
    _title = text;
    notifyListeners();
  }

  void setContent({String text}) {
    _content = text;
    notifyListeners();
  }

  Future<void> setTag(String text) async {
    _tagName = text.isEmpty ? "#" : text.replaceAll(' ', '').toLowerCase();
    notifyListeners();
  }

  Future<void> setColor(int color) async {
    _color = color;
    notifyListeners();
  }
}
