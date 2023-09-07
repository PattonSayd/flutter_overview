import 'package:flutter/material.dart';
import 'package:flutter_overview/topic_node.dart';
import 'package:flutter_overview/topics_list_view.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key, required this.topic});

  final TopicNode topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: HeroTopicTitle(topicNode: topic)),
      body: TopicsListView(topics: topic.subtopics),
    );
  }
}
