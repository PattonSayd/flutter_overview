import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overview/topic_node.dart';
import 'package:flutter_overview/topic_parser.dart';
import 'package:flutter_overview/topics_list_view.dart';

import 'doc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TopicNode>? topics;

  @override
  void initState() {
    super.initState();
    _initMatrix().then((topics) => setState(() => this.topics = topics));
  }

  Future<List<TopicNode>> _initMatrix() async {
    // resurslar(assets) haqqında metadata, matrix qovluğu
    final manifestAssets = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestAssets);

    // cupertino_icons şrift faylının manifestAssetsdən silinməsi
    if (manifestMap
        .containsKey('packages/cupertino_icons/assets/CupertinoIcons.ttf')) {
      manifestMap.remove('packages/cupertino_icons/assets/CupertinoIcons.ttf');
    }

    final topicsPaths = manifestMap.keys.toList(growable: false);

    final topics = <String, Doc>{};

    for (final path in topicsPaths) {
      // contentin alınması
      final content = await rootBundle.loadString(path);
      final topic = Doc(path, content);
      topics[topic.path] = topic;
    }

    final skillsMap = topics.remove('matrix/skills_map.md')!;
    final topLevelTopics = TopicsParser.parse(skillsMap.content);
    TopicsParser.printTopicsTree(topLevelTopics);
    return topLevelTopics;
  }

  @override
  Widget build(BuildContext context) {
    final list = topics;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dev Topics'),
      ),
      body: list != null
          ? TopicsListView(topics: list)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
