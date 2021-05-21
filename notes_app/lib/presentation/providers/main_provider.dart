import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/domain/models/notemodal.dart';
import 'package:notes_app/domain/models/tagmodal.dart';

class MainProvider extends ChangeNotifier {
  static const String _boxTagName = "tagBox";
  static const String _boxNoteName = "noteBox";
  List<NoteModal> _noteList = <NoteModal>[];
  NoteModal _selectNote;
  NoteModal get selectNote => _selectNote;
  List<TagModal> _tagList = <TagModal>[];
  bool _tagItemSelected = false;
  bool get tagItemSelected => _tagItemSelected;
  List<NoteModal> get noteList =>
      _noteList..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  List<TagModal> get tagList => _tagList;
  List<NoteModal> _noteArchiveList = <NoteModal>[];
  List<NoteModal> get noteArchiveList => _noteArchiveList;
  List<NoteModal> _noteImportantList = <NoteModal>[];
  List<NoteModal> get noteImportantList => _noteImportantList;

  int _tagValue;
  int get tagValue => _tagValue;
  String _titleBar = 'notes';
  get titleBar => _titleBar;
  bool _visibilitySearhAndTags = true;
  bool get visibilitySearchAndTags => _visibilitySearhAndTags;
  bool _writeSearch = false;
  bool get writeSearch => _writeSearch;
  bool _addTagShow = false;
  bool get addTagShow => _addTagShow;
  int _howPageNoteList = 0;
  int get howPageNoteList => _howPageNoteList;
  String _emptyNote = "emptyNote";
  String get emptyNote => _emptyNote;
  Box<NoteModal> noteBox = Hive.box<NoteModal>(_boxNoteName);
  Box<TagModal> tagBox = Hive.box<TagModal>(_boxTagName);
  void addTagVisibility({bool s}) {
    _addTagShow = s == null ? !_addTagShow : s;
    notifyListeners();
  }

  void setHowPage(int pageIndex) {
    _howPageNoteList = pageIndex;
    notifyListeners();
  }

  List<int> _colorList = [
    0xFF111D5E,
    0xFFC70039,
    0xFFf37121,
    0xFFc0e218,
    0xff14ffec,
    0xff212121,
    0xff323232,
    0xff0d7377,
  ];
  List<int> get colorList => _colorList;

  searchSuffixVisibilityTrue() {
    _writeSearch = true;
    notifyListeners();
  }

  searchSuffixVisibilityFalse() {
    _writeSearch = false;
    notifyListeners();
  }

  set setVisibilitySearchAndTags(bool show) {
    _visibilitySearhAndTags = show;
    notifyListeners();
  }

  set setTitleBar(String title) {
    _titleBar = title;
    notifyListeners();
  }

  set setTagValue(int a) {
    _tagValue = a;
    notifyListeners();
  }

  int get noteListCount {
    return _noteList.length;
  }

  Future<void> initData() async {
    await loadTags();
    await allLoadNotes();
  }

  Future<void> loadTags() async {
    var box = await Hive.openBox<TagModal>(_boxTagName);
    _tagList = box.values.toList();
    notifyListeners();
  }

  Future<void> getImportantNote() async {
    final result = noteBox.values
        .where((element) => element.isImportant == true)
        .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    _emptyNote = "emptyImportantNote";
    _noteList = result;
    notifyListeners();
  }

  Future<void> getArchiveNote() async {
    final result = noteBox.values
        .where((element) => element.isArchive == true)
        .toList()
          ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    _emptyNote = "emptyArchiveNote";

    _noteList = result;

    notifyListeners();
  }

  getTagColor(int id) {
    final result = _tagList.firstWhere((element) => element.key == id);
    return result.color;
  }

  NoteModal getNote(int id) {
    return _noteList.firstWhere((element) => element.key == id);
  }

  Future<void> createNoteTag(TagModal tag, NoteModal note) async {
    print(tag.tagName);
    print(tag.color);
    print(note.title);

    tag.tagName.isEmpty ? tag.tagName = "#" : tag.tagName = tag.tagName;
    final isTag = _tagList.any((element) => element.tagName == tag.tagName);
    if (isTag) {
      print(isTag);
      final int tagId = await matchTagId(tag.tagName);
      print(note.tagId);
      createNote(note, tagId);
    } else {
      createTag(tag);
      final int tagId = await matchTagId(tag.tagName);
      print(tagId);

      createNote(note, tagId);
      print(tag.key);
    }
  }

  Future<void> deleteTag(id) async {
    var boxTag = await Hive.openBox<TagModal>(_boxTagName);
    var boxNote = await Hive.openBox<NoteModal>(_boxNoteName);
    _tagList.removeWhere((element) => element.key == id);
    await boxTag.delete(id);
    final result =
        boxNote.values.where((element) => element.tagId == id).toList();
    final _tagName = "#";
    final _isTag = _tagList.any((element) => element.tagName == _tagName);
    if (_isTag) {
      final int _tagId = await matchTagId(_tagName);
      for (var result in result) {
        updateNoteTagId(result, _tagId);
      }
    } else {
      final tag = TagModal(tagName: "#", color: 0);
      createTag(tag);
      final int _tagId = await matchTagId(_tagName);
      for (var result in result) {
        updateNoteTagId(result, _tagId);
      }
    }

    notifyListeners();
  }

  Future<bool> matchTag(String tag) async {
    final result = tagBox.values.every((element) => element.tagName == tag);
    return result;
  }

  Future<int> matchTagId(String tag) async {
    final result =
        tagBox.values.firstWhere((element) => element.tagName == tag);
    return result.key;
  }

  Future<void> updateNoteTagId(NoteModal note, int tagId) async {
    final _notes = NoteModal(
      title: note.title,
      content: note.content,
      tagId: tagId,
      dateTime: note.dateTime,
      isArchive: note.isArchive,
      isImportant: note.isImportant,
    );
    await noteBox.put(note.key, _notes);
    _noteList = noteBox.values.toList();
    await initData();
    notifyListeners();
  }

  Future<void> updateIsImportant(
      int id, NoteModal note, bool isImportant) async {
    final notes = NoteModal(
      title: note.title,
      content: note.content,
      tagId: note.tagId,
      dateTime: note.dateTime,
      isArchive: note.isArchive,
      isImportant: isImportant,
    );
    final notesChangeArchive = NoteModal(
      title: note.title,
      content: note.content,
      tagId: note.tagId,
      dateTime: note.dateTime,
      isArchive: !note.isArchive,
      isImportant: isImportant,
    );
    final result = note.isArchive ? notesChangeArchive : notes;
    await noteBox.put(id, result);
    _noteList = noteBox.values.toList();
    await allLoadNotes();
    notifyListeners();
  }

  Future<void> updateIsArchive(int id, NoteModal note, bool isArchive) async {
    final notes = NoteModal(
      title: note.title,
      content: note.content,
      tagId: note.tagId,
      dateTime: note.dateTime,
      isArchive: isArchive,
      isImportant: note.isImportant,
    );

    final notesChangeImportant = NoteModal(
      title: note.title,
      content: note.content,
      tagId: note.tagId,
      dateTime: note.dateTime,
      isArchive: isArchive,
      isImportant: !note.isImportant,
    );
    final result = note.isImportant ? notesChangeImportant : notes;
    await noteBox.put(id, result);
    _noteList = noteBox.values.toList();
    await allLoadNotes();
    notifyListeners();
  }

  Future<void> editNote(NoteModal note, int id) async {
    await noteBox.put(id, note);
    _noteList = noteBox.values.toList();
    notifyListeners();
    await allLoadNotes();
  }

  Future<void> editTag(int id, TagModal tag) async {
    await tagBox.put(id, tag);
    _tagList = tagBox.values.toList();
    notifyListeners();
    await loadTags();
  }

  Future<void> createTag(TagModal tag) async {
    await tagBox.add(tag);
    _tagList = tagBox.values.toList();
    notifyListeners();
  }

  Future<void> searchNote(String name) async {
    name == null ? name = "" : name = name;
    noteList.clear();
    final result = noteBox.values
        .where((element) => element.title == name || element.content == name)
        .toList();
    _noteList = result;
    notifyListeners();
  }

  Future<void> getAllLoads() async {
    final result = noteBox.values
        .where((element) =>
            element.isArchive == false &&
            (element.isImportant == false || element.isImportant == true))
        .toList()
          ..reversed;
    _emptyNote = "emptyNote";
    _noteList = result;
    notifyListeners();
  }

  Future<void> allLoadNotes() async {
    switch (_howPageNoteList) {
      case 0:
        await getAllLoads();
        break;
      case 1:
        await getImportantNote();
        break;
      case 2:
        await getArchiveNote();
        break;
    }

    _tagItemSelected = false;
    _tagValue = null;
    notifyListeners();
  }

  Future<void> loadNotes(int id) async {
    final result = noteBox.values
        .where((element) => element.tagId == id && element.isArchive == false)
        .toList();
    _noteList = result;
    notifyListeners();
  }

  Future<void> createNote(NoteModal note, int tagId) async {
    await noteBox.add(NoteModal(
      title: note.title,
      content: note.content,
      tagId: tagId,
      dateTime: note.dateTime,
      isArchive: note.isArchive,
      isImportant: note.isImportant,
    ));
    _noteList = noteBox.values.toList();
    await allLoadNotes();
    notifyListeners();
  }

  Future<void> deleteNote(int id, int tagId) async {
    final result =
        noteBox.values.where((element) => element.tagId == tagId).toList();
    if (result.length > 1) {
      _noteList.removeWhere((element) => element.key == id);
      await noteBox.delete(id);
    } else {
      _noteList.removeWhere((element) => element.key == id);
      await noteBox.delete(id);
      _tagList.removeWhere((element) => element.key == tagId);
      await tagBox.delete(tagId);
    }

    print(id);
    await allLoadNotes();
    notifyListeners();
  }

  Future<void> deleteAll() async {
    _noteList.clear();
    await noteBox.deleteFromDisk();
    _tagList.clear();
    await tagBox.deleteFromDisk();
    await allLoadNotes();
  }
}
