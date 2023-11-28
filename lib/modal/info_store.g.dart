// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InfoStore on _InfoStore, Store {
  late final _$infosAtom = Atom(name: '_InfoStore.infos', context: context);

  @override
  ObservableList<String> get infos {
    _$infosAtom.reportRead();
    return super.infos;
  }

  @override
  set infos(ObservableList<String> value) {
    _$infosAtom.reportWrite(value, super.infos, () {
      super.infos = value;
    });
  }

  late final _$addInfoAsyncAction =
      AsyncAction('_InfoStore.addInfo', context: context);

  @override
  Future<void> addInfo(String info) {
    return _$addInfoAsyncAction.run(() => super.addInfo(info));
  }

  late final _$removeInfoAsyncAction =
      AsyncAction('_InfoStore.removeInfo', context: context);

  @override
  Future<void> removeInfo(String info) {
    return _$removeInfoAsyncAction.run(() => super.removeInfo(info));
  }

  @override
  String toString() {
    return '''
infos: ${infos}
    ''';
  }
}
