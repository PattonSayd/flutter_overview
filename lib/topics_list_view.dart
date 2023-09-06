import 'package:flutter/material.dart';
import 'package:flutter_overview/topic_node.dart';
import 'package:flutter_overview/topic_page.dart';

class TopicsListView extends StatelessWidget {
  const TopicsListView({super.key, required this.topics});

  final List<TopicNode> topics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(topics[index].topic),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicPage(topic: topics[index]),
          ),
        ),
      ),
      itemCount: topics.length,
    );
    ;
  }
}