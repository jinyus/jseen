// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easy_treeview/flutter_easy_treeview.dart';
import 'package:jseen/constants.dart';
import 'package:jseen/theme.dart';
import 'package:jseen/utils.dart';

part 'collapsable_key.dart';

class JSeenTree extends StatefulWidget {
  const JSeenTree({
    Key? key,
    required this.json,
    this.shouldParse = true,
    this.expandAll = true,
    this.indent = 10,
    this.theme = const JSeenTheme(),
  }) : super(key: key);

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

  final double indent;

  final bool expandAll;

  @override
  _JSeenTreeState createState() => _JSeenTreeState();
}

class _JSeenTreeState extends State<JSeenTree> {
  final treeController = EasyTreeController<Widget>();
  late EasyTreeConfiguration configuration;

  late List<EasyTreeNode<Widget>> nodes;
  @override
  void initState() {
    super.initState();
    final parsed = widget.shouldParse ? jsonDecode(widget.json) : widget.json;
    nodes = [mapEntryToNode(parsed)];

    configuration = EasyTreeConfiguration(
      defaultExpandAll: widget.expandAll,
      padding: EdgeInsets.only(bottom: 5),
      indent: widget.indent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return EasyTreeView<Widget>(
      nodes: nodes,
      controller: treeController,
      configuration: configuration,
      callback: (EasyTreeNode<Widget> node) {
        if (node.isLeaf) {
          treeController.select(node);
        } else {
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

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  prefix,
                  node.data,
                  suffix,
                ],
              ),
              margin: const EdgeInsets.only(left: 10),
            ),
          ],
        );
      },
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
              child:
                  SelectableText('${entry.key}', style: widget.theme.keyStyle),
            ),
            children:
                (entry.value as Map).entries.map(mapEntryToNode).toList());
      } else if (entry.value is List) {
        return EasyTreeNode(
            data: _CollapsableKey(
              collapsedInfo: 'Array(${entry.value.length})',
              child:
                  SelectableText('${entry.key}', style: widget.theme.keyStyle),
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
