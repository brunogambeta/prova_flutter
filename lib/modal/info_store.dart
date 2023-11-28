import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'info_store.g.dart';

class InfoStore = _InfoStore with _$InfoStore;

abstract class _InfoStore with Store {
  @observable
  ObservableList<String> infos = ObservableList<String>();

  @action
  Future<void> addInfo(String info) async {
    infos.add(info);
    await _saveToPrefs();
  }

  @action
  Future<void> editInfo(int index, String newInfo) async {
    if (index >= 0 && index < infos.length) {
      infos[index] = newInfo;
      await _saveToPrefs();
    }
  }

  @action
  Future<void> removeInfo(String info) async {
    infos.remove(info);
    await _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('infos', infos.toList());
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedInfos = prefs.getStringList('infos');
    if (savedInfos != null) {
      infos = ObservableList.of(savedInfos);
    }
  }
}
