import 'package:crowdfunding_flutter/common/theme/color.dart';
import 'package:crowdfunding_flutter/common/utils/extensions/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class CustomStepper extends StatefulWidget {
  final List<CustomStep> steps;
  final int currentStep;
  const CustomStepper({
    super.key,
    required this.steps,
    this.currentStep = 1,
  });

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  Widget _buildLine(int index) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints(minHeight: 26),
        width: 2.0,
        color: widget.currentStep - 1 > index
            ? CustomColors.accentGreen
            : CustomColors.slate300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.steps.length,
      itemBuilder: (context, index) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  HeroIcon(
                    HeroIcons.checkCircle,
                    size: 30,
                    color: widget.currentStep > index
                        ? CustomColors.accentGreen
                        : CustomColors.slate300,
                  ),
                  if (index != widget.steps.length - 1) _buildLine(index),
                ],
              ),
              12.kW,
              Flexible(
                child: Opacity(
                  opacity: index + 1 > widget.currentStep ? 0.4 : 1,
                  child: widget.steps[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomStep extends StatelessWidget {
  final Widget title;
  const CustomStep({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: title,
        ),
      ],
    );
  }
}
