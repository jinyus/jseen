// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_treeview/flutter_easy_treeview.dart';
import 'package:jseen/constants.dart';
import 'package:jseen/theme.dart';
import 'package:jseen/utils.dart';

part 'collapsable_key.dart';

class JSeenTree extends StatefulWidget {
  JSeenTree({
    Key? key,
    required this.json,
    this.shouldParse = true,
    this.expandAll = true,
    this.indent = 10,
    this.theme = const JSeenTheme(),
    this.errorWidget = kErrorWidget,
  })  : assert(json is String && shouldParse || json is! String && !shouldParse,
            "[shouldParse] must be true is [json] is a String\n[shouldParse] must be false if [json] is not a String"),
        super(
            key: key ??
                ValueKey(
                  shouldParse.hashCode ^
                      expandAll.hashCode ^
                      json.hashCode ^
                      indent.hashCode ^
                      errorWidget.hashCode,
                ));

  /// theme specifying how the json values should look
  final JSeenTheme theme;

  /// The json object, this can be a json string
  /// [shouldParse] should be set to [false] if a
  /// value json object was passed. (List,Map etc.)
  final dynamic json;

  /// Whether or not [jsonDecode()] should be called
  /// on the json that was passed. This should be
  /// set to false if the you've already decoded
  /// the object.
  final bool shouldParse;

  /// This widget will be shown at the moment
  /// when the package cannot handle the value.
  final Widget errorWidget;

  final double indent;

  final bool expandAll;

  @override
  _JSeenTreeState createState() => _JSeenTreeState();
}

class _JSeenTreeState extends State<JSeenTree> {
  final treeController = EasyTreeController<Widget>();
  late EasyTreeConfiguration configuration;

  late List<EasyTreeNode<Widget>> nodes;
  bool failed = false;
  @override
  void initState() {
    super.initState();
    try {
      final parsed = widget.shouldParse ? jsonDecode(widget.json) : widget.json;
      nodes = [mapEntryToNode(parsed)];
    } catch (e, s) {
      if (kDebugMode) {
        print('encoding failed: $e\n$s');
      }
      failed = true;
    }

    configuration = EasyTreeConfiguration(
      defaultExpandAll: widget.expandAll,
      padding: EdgeInsets.only(bottom: 5),
      indent: widget.indent,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (failed) return widget.errorWidget;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 5000,
        child: EasyTreeView<Widget>(
          nodes: nodes,
          controller: treeController,
          configuration: configuration,
          callback: (node) {
            if (!node.isLeaf) {
              treeController.onClick(node);
            }
          },
          itemBuilder: (BuildContext context, EasyTreeNode<Widget> node) {
            Widget prefix = SizedBox(width: kIconSize);
            Widget suffix = SizedBox.shrink();

            if (!node.isLeaf) {
              if (node.expanded) {
                prefix = widget.theme.openIcon;
              } else {
                prefix = widget.theme.closeIcon;
                suffix = Text(
                  " : " + (node.data as _CollapsableKey).collapsedInfo,
                );
              }
            }

            return Container(
              child: Row(
                children: [
                  prefix,
                  node.data,
                  suffix,
                ],
              ),
              margin: const EdgeInsets.only(left: 10),
            );
          },
        ),
      ),
    );
  }

  EasyTreeNode<Widget> mapEntryToNode(dynamic entry) {
    if (entry is Map) {
      return EasyTreeNode(
        data: _CollapsableKey(
          collapsedInfo: 'Object(${entry.length})',
          child: SizedBox.shrink(),
        ),
        children: entry.entries.map(mapEntryToNode).toList(),
      );
    } else if (entry is List) {
      return EasyTreeNode(
        data: _CollapsableKey(
          collapsedInfo: 'Array(${entry.length})',
          child: SizedBox.shrink(),
        ),
        children: entry.map(mapEntryToNode).toList(),
      );
    } else if (entry is MapEntry) {
      if (entry.value is Map) {
        return EasyTreeNode(
            data: _CollapsableKey(
              collapsedInfo: 'Object(${entry.value.length})',
              child: Text('${entry.key}', style: widget.theme.keyStyle),
            ),
            children:
                (entry.value as Map).entries.map(mapEntryToNode).toList());
      } else if (entry.value is List) {
        return EasyTreeNode(
            data: _CollapsableKey(
              collapsedInfo: 'Array(${entry.value.length})',
              child: Text('${entry.key}', style: widget.theme.keyStyle),
            ),
            children: (entry.value as List).map(mapEntryToNode).toList());
      } else {
        return EasyTreeNode(
          data: SelectableText.rich(
            TextSpan(
                text: '${entry.key}',
                style: widget.theme.keyStyle,
                children: [
                  TextSpan(text: ': '),
                  TextSpan(
                      text: '${entry.value}',
                      style: mapValueToStyle(entry.value, widget.theme)),
                ]),
          ),
        );
      }
    } else {
      return EasyTreeNode(
        data: SelectableText('$entry',
            style: mapValueToStyle(entry, widget.theme)),
      );
    }
  }
}
