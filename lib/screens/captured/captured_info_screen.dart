import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../modal/info_store.dart';
import '../../utils/dialogs_utils.dart';
import '../../utils/privacy_policy.dart';

class CapturedInfoScreen extends StatefulWidget {
  const CapturedInfoScreen({Key? key}) : super(key: key);

  @override
  _CapturedInfoScreenState createState() => _CapturedInfoScreenState();
}

class _CapturedInfoScreenState extends State<CapturedInfoScreen> {
  final FocusNode _focusNode = FocusNode();
  final InfoStore infoStore = InfoStore();
  final TextEditingController _textController = TextEditingController();
  String selectedInfo = '';

  @override
  void initState() {
    super.initState();
    infoStore.loadFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(27, 76, 96, 1),
                Color.fromRGBO(42, 141, 136, 1.0),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                    maxHeight: double.infinity,
                  ),
                  height: 300,
                  color: Colors.white,
                  child: Observer(
                    builder: (_) => ListView.builder(
                      itemCount: infoStore.infos.length,
                      itemBuilder: (_, index) {
                        final info = infoStore.infos[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              info,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: () {
                                    _startEditing(info);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => showDeleteConfirmationDialog(
                                      context, infoStore, info),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextField(
                  focusNode: _focusNode,
                  controller: _textController,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'Digite seu texto',
                    fillColor: Colors.white,
                  ),
                  style: const TextStyle(fontSize: 18),
                  onSubmitted: (text) {
                    _saveInfo(text);
                  },
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  showPrivacyPolicy(context);
                },
                child: const Text(
                  'Política de privacidade',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startEditing(String info) {
    setState(() {
      selectedInfo = info;
      _textController.text = info;
    });
  }

  void _saveInfo(String text) {
    if (selectedInfo.isNotEmpty) {
      infoStore.editInfo(infoStore.infos.indexOf(selectedInfo), text);
    } else {
      infoStore.addInfo(text);
    }
    _textController.clear();
    selectedInfo = '';
  }
}
