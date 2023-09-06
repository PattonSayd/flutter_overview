import 'package:flutter_overview/topic_node.dart';

class _ParsedTopicNodes {
  final List<TopicNode> nodes;
  final int endIndex;

  _ParsedTopicNodes(this.nodes, this.endIndex);
}

class TopicsParser {
  const TopicsParser._();

  static List<TopicNode> parse(String string) {
    final List<String> lines = string.split('\n');
    final parseTopicNodes = _parseTopicNodes(lines, 0, 0).nodes;
    return parseTopicNodes;
  }

  static _ParsedTopicNodes _parseTopicNodes(
    List<String> lines,
    int lineIndex,
    int indentLevel,
  ) {
    final List<TopicNode> nodes = [];

    while (lineIndex < lines.length) {
      final String line = lines[lineIndex];
      final int currentIndentLevel = _getIndentLecel(line);

      if (currentIndentLevel < indentLevel) {
        break;
      } else if (currentIndentLevel == indentLevel) {
        nodes.add(TopicNode(line.replaceAll('-', '').trim(), []));
        lineIndex++;
      } else {
        TopicNode lastNode = nodes.last;
        _ParsedTopicNodes result =
            _parseTopicNodes(lines, lineIndex, currentIndentLevel);
        lastNode.subtopics.addAll(result.nodes);
        lineIndex = result.endIndex;
      }
    }

    return _ParsedTopicNodes(nodes, lineIndex);
  }

  static int _getIndentLecel(String line) {
    int i = 0;
    while (i < line.length && line[i] == ' ') {
      i++;
    }
    return i ~/ 2;
  }

  static void printTopicsTree(List<TopicNode> topics) {
    for (TopicNode topic in topics) {
      _printTopicNode(topic, 0);
    }
  }

  static void _printTopicNode(TopicNode node, int depth) {
    final String prefix = '${'  ' * depth}- ';
    print('$prefix${node.topic}');

    for (var subTopic in node.subtopics) {
      _printTopicNode(subTopic, depth + 1);
    }
  }
}
