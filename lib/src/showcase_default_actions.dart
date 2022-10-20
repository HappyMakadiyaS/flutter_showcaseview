import 'package:flutter/material.dart';

import '../showcaseview.dart';

class ShowCaseDefaultActions extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final double? dividerThickness;
  final Color verticalDividerColor;
  final BuildContext showCaseViewContext;
  final ActionButtonConfig next;
  final ActionButtonConfig previous;
  final ActionButtonConfig stop;

  const ShowCaseDefaultActions({
    Key? key,
    this.next = const ActionButtonConfig(),
    this.previous = const ActionButtonConfig(),
    this.stop = const ActionButtonConfig(),
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.dividerThickness = 1.0,
    this.verticalDividerColor = const Color(0xffee5366),
    required this.showCaseViewContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      verticalDirection: verticalDirection,
      crossAxisAlignment: crossAxisAlignment,
      textBaseline: textBaseline,
      textDirection: textDirection,
      children: [
        if (previous.buttonVisible)
          _getButtonWidget(
            previous,
            previous.text ?? 'Previous',
            previous.callback ??
                () {
                  if (ShowCaseWidget.of(showCaseViewContext).ids != null) {
                    ShowCaseWidget.of(showCaseViewContext).previous();
                  }
                },
          ),
        if (previous.buttonVisible && stop.buttonVisible ||
            previous.buttonVisible && next.buttonVisible)
          _getVerticalDivider(),
        if (stop.buttonVisible)
          _getButtonWidget(
            stop,
            stop.text ?? 'Stop',
            stop.callback ??
                () {
                  if (ShowCaseWidget.of(showCaseViewContext).ids != null) {
                    ShowCaseWidget.of(showCaseViewContext).dismiss();
                  }
                },
          ),
        if (stop.buttonVisible && next.buttonVisible) _getVerticalDivider(),
        if (next.buttonVisible)
          _getButtonWidget(
            next,
            next.text ?? 'Next',
            next.callback ??
                () {
                  if (ShowCaseWidget.of(showCaseViewContext).ids != null) {
                    ShowCaseWidget.of(showCaseViewContext).completed(
                        ShowCaseWidget.of(showCaseViewContext).ids![
                            ShowCaseWidget.of(showCaseViewContext).activeWidgetId ??
                                0]);
                  }
                },
          ),
      ],
    );
  }

  Widget _getVerticalDivider() {
    return VerticalDivider(
      width: 1.0,
      thickness: dividerThickness,
      color: verticalDividerColor,
    );
  }

  Widget _getButtonWidget(ActionButtonConfig actionConfig, String buttonText, VoidCallback onClick) {
    return Expanded(
      child: Directionality(
        textDirection: actionConfig.textDirection,
        child: TextButton.icon(
          label: actionConfig.buttonTextVisible
              ? Text(
                  buttonText,
                  style: TextStyle(color: actionConfig.textColor),
                )
              : const SizedBox.shrink(),
          icon: actionConfig.icon ?? const SizedBox.shrink(),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  actionConfig.textButtonBgColor)),
          onPressed: onClick,
        ),
      ),
    );
  }
}

class ActionButtonConfig {
  /// button text
  final String? text;

  /// button icon or image
  final Widget? icon;

  /// Color of button text.
  final Color textColor;

  /// Color of button background.
  final Color textButtonBgColor;

  /// Callback on button tap.
  ///
  /// Note: Default callback will be overridden by this one.
  final VoidCallback? callback;

  /// Defines visibility of button.
  final bool buttonVisible;

  /// Defines visibility of button.
  final bool buttonTextVisible;

  /// Defines icon and text direction.
  final TextDirection textDirection;

  const ActionButtonConfig({
    this.text,
    this.icon,
    this.textColor = const Color(0xffee5366),
    this.textButtonBgColor = Colors.transparent,
    this.callback,
    this.buttonVisible = true,
    this.buttonTextVisible = true,
    this.textDirection = TextDirection.ltr,
  });
}
