import 'package:flutter/material.dart';

import 'package:flutter_overview/topic_node.dart';
import 'package:flutter_overview/topic_page.dart';

class TopicsListView extends StatelessWidget {
  const TopicsListView({super.key, required this.topics});

  final List<TopicNode> topics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => TopicTile(
        topicNode: topics[index],
      ),
      itemCount: topics.length,
    );
  }
}

class TopicTile extends StatelessWidget {
  const TopicTile({
    Key? key,
    required this.topicNode,
  }) : super(key: key);

  final TopicNode topicNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: HeroTopicTitle(topicNode: topicNode),
        subtitle: Wrap(
          children: topicNode.subtopics
              .map((subtopic) => TopicChip(topic: subtopic))
              .toList(),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicPage(topic: topicNode),
          ),
        ),
      ),
    );
  }
}

class HeroTopicTitle extends StatelessWidget {
  const HeroTopicTitle({
    Key? key,
    required this.topicNode,
  }) : super(key: key);

  final TopicNode topicNode;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topicNode.topic,
      child: Material(
        color: Colors.transparent,
        child: Text(
          topicNode.topic,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}

class TopicChip extends StatelessWidget {
  const TopicChip({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final TopicNode topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      ),
      margin: const EdgeInsets.all(2.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Text(
          topic.topic,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
