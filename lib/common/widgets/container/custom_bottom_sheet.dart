import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDraggableSheet extends StatefulWidget {
  final Widget child;
  final Widget? footer;
  final List<double>? snapSizes;
  final double initialChildSize;
  const CustomDraggableSheet({
    super.key,
    required this.child,
    this.initialChildSize = 0.5,
    this.snapSizes,
    this.footer,
  });

  @override
  State<CustomDraggableSheet> createState() => _CustomDraggableSheetState();
}

class _CustomDraggableSheetState extends State<CustomDraggableSheet> {
  final sheet = GlobalKey();
  final controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onChanged);
  }

  void onChanged() {
    // final currentSize = controller.size;
    // if (currentSize <= 0.3) context.pop();
  }

  // void collapse() => animateSheet(getSheet.snapSizes!.first);

  void animateSheet(double size) {
    controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  DraggableScrollableSheet get getSheet =>
      (sheet.currentWidget as DraggableScrollableSheet);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return DraggableScrollableSheet(
        key: sheet,
        initialChildSize: widget.initialChildSize,
        maxChildSize: 0.95,
        minChildSize: 0.2,
        expand: true,
        snap: true,
        snapSizes: widget.snapSizes,
        controller: controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                topButtonIndicator(),
                SliverToBoxAdapter(
                  child: Container(
                    child: widget.child,
                  ),
                ),
                if (widget.footer != null)
                  // Footer widget
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //footer widgets,
                        widget.footer!,
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      );
    });
  }

  SliverToBoxAdapter topButtonIndicator() {
    return SliverToBoxAdapter(
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Container(
                child: Center(
                    child: Wrap(children: <Widget>[
              Container(
                  width: 100,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  )),
            ]))),
          ])),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Widget child;
  final Widget? bottomAction;
  final AlignmentGeometry contentAlignment;
  const CustomBottomSheet({
    super.key,
    this.padding = const EdgeInsets.only(
      top: 8,
      left: 20,
      right: 20,
      bottom: 20,
    ),
    required this.child,
    this.bottomAction,
    this.contentAlignment = Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Stack(
        alignment: contentAlignment,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  20.kH,
                  child,
                ],
              ),
            ),
          ),
          // Drag handler indicator
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SvgPicture.asset(
                  "assets/icons/bottom-sheet-top-close-indicator.svg"),
            ),
          ),
          if (bottomAction != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: CustomColors.divider),
                  ),
                ),
                child: bottomAction,
              ),
            ),
        ],
      ),
    );
  }
}
