part of 'jseen_tree.dart';

class _CollapsableKey extends StatelessWidget {
  final String collapsedInfo;
  final Widget child;
  const _CollapsableKey({
    Key? key,
    required this.collapsedInfo,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
