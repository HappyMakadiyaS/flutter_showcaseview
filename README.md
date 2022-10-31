![Showcaes View - Simform LLC.](https://github.com/SimformSolutionsPvtLtd/flutter_showcaseview/blob/master/preview/banner.png?raw=true)


# ShowCaseView

[![Build](https://github.com/SimformSolutionsPvtLtd/flutter_showcaseview/workflows/Build/badge.svg?branch=master)](https://github.com/SimformSolutionsPvtLtd/flutter_showcaseview/actions) [![showcaseview](https://img.shields.io/pub/v/showcaseview?label=showcaseview)](https://pub.dev/packages/showcaseview)

A Flutter package allows you to Showcase/Highlight your widgets step by step.

## Preview

![The example app running in Android](https://github.com/simformsolutions/flutter_showcaseview/blob/master/preview/showcaseview.gif)

## Migration guide for release 2.0
Release 2.0 contains breaking changes in terms of renaming some of the properties from `ShowCaseWidget` and `Showcase` class which is listed below in the table.

<table>
<tr><th>Before</th><th>After</th></tr>
<tr><td>autoPlayLockEnable</td><td>enableAutoPlayLock</td></tr>
<tr><td>shapeBorder</td><td>targetShapeBorder</td></tr>
<tr><td>showcaseBackgroundColor</td><td>tooltipBackgroundColor</td></tr>
<tr><td>contentPadding</td><td>tooltipPadding</td></tr>
<tr><td>overlayPadding</td><td>targetPadding</td></tr>
<tr><td>radius</td><td>targetBorderRadius</td></tr>
<tr><td>tipBorderRadius</td><td>tooltipBorderRadius</td></tr>
</table>

Unused parameters of `Showcase.withWidget()` which are not impacting view of showcase widget that has been removed from parameter list of the named constructor `Showcase.withWidget()`.

The list of parameters are:
<ul>
<li>title</li>
<li>titleAlignment</li>
<li>titleTextStyle</li>
<li>description</li>
<li>descriptionAlignment</li>
<li>descTextStyle</li>
<li>textColor</li>
<li>tooltipBackgroundColor</li>
<li>tooltipBorderRadius</li>
<li>tooltipPadding</li>
</ul>

## Installing

1.  Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on [pub.dev](https://pub.dev/packages/showcaseview)*

```dart
dependencies:
    showcaseview: <latest-version>
```

2.  Import the package
```dart
import 'package:showcaseview/showcaseview.dart';
```

3. Adding a `ShowCaseWidget` widget.
```dart
ShowCaseWidget(
  builder: Builder(
    builder : (context)=> Somewidget()
  ),
),
```

4. Adding a `Showcase` widget.
```dart
GlobalKey _one = GlobalKey();
GlobalKey _two = GlobalKey();
GlobalKey _three = GlobalKey();

...

Showcase(
  key: _one,
  title: 'Menu',
  description: 'Click here to see menu options',
  child: Icon(
    Icons.menu,
    color: Colors.black45,
  ),
),
```

Some more optional parameters

```dart
Showcase(
  key: _two,
  title: 'Profile',
  description: 'Click here to go to your Profile',
  titleAlignment: TextAlign.start,
  descriptionAlignment: TextAlign.start,
  disableAnimation: true,
  targetShapeBorder: CircleBorder(),
  targetBorderRadius: BorderRadius.all(Radius.circular(40)),
  showArrow: false,
  tooltipBorderRadius: BorderRadius.all(Radius.circular(8)),
  targetPadding: EdgeInsets.all(5),
  slideDuration: Duration(milliseconds: 1500),
  tooltipBackgroundColor: Colors.blueGrey,
  blurValue: 2,
  disableDefaultTargetGestures: true,
  child: ...,
),
```

5. Using a `Showcase.withWidget` widget.

```dart
Showcase.withWidget(
  key: _three,
  height: 80,
  width: 140,
  targetShapeBorder: CircleBorder(),
  container: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ...
    ],
  ),
  child: ...,
),
```

6. Starting the `ShowCase`
```dart
someEvent(){
    ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
}
```

7. onFinish method for `ShowCase`
```dart
ShowCaseWidget(
  onFinish: () {
    // Your code goes here
  },
  builder: Builder(
    builder : (context) ()=> Somewidget()
  ),
),
```

8. Go to next `ShowCase`
```dart
someEvent(){
  ShowCaseWidget.of(context).next();
}
```

9. Go to previous `ShowCase`
```dart
someEvent(){
  ShowCaseWidget.of(context).previous();
}
```

If you want to start the `ShowCaseView` as soon as your UI built up then use below code.

```dart
WidgetsBinding.instance.addPostFrameCallback((_) =>
  ShowCaseWidget.of(context).startShowCase([_one, _two, _three])
);
```

If you want to disable barrier interaction then set `disableBarrierInteraction` parameter to true.  

```dart
ShowCaseWidget(
  disableBarrierInteraction: true,
),
```

If you want to disable default gestures of target widget then set `disableDefaultTargetGestures` parameter to true in Showcase.
Note: Make sure to dismiss current showcase with `ShowCaseWidget.of(context).dismiss()` if you are navigating to other screen.
This will be handled by default if `disableDefaultTargetGestures` is set to false.

```dart
ShowCase(
  disableDefaultTargetGestures: true,
),
```

## Properties of `ShowCaseWidget`:

| Name                      | Type                        | Default Behaviour            | Description                                                                          |
|---------------------------|-----------------------------|------------------------------|--------------------------------------------------------------------------------------|
| onStart                   | Function(int?, GlobalKey)?  |                              | Triggered on start of each showcase.                                                 |
| onComplete                | Function(int?, GlobalKey)?  |                              | Triggered on completion of each showcase.                                            |
| onFinish                  | VoidCallback?               |                              | Triggered when all the showcases are completed                                       |
| blurValue                 | double                      | 0                            | Provides gaussian blur effect on overlay                                             |
| autoPlay                  | bool                        | false                        | Automatically display Next showcase after specified amount of time - `autoPlayDelay` |
| autoPlayDelay             | Duration                    | Duration(milliseconds: 2000) | Visibility time of showcase when `autoplay` is enabled                               |
| enableAutoPlayLock        | bool                        | false                        | Disable the user interaction on overlay when autoPlay is enabled.                    |
| enableAutoScroll          | bool                        | false                        | Allows to auto scroll to next showcase so as to make the given widget visible.       |
| scrollDuration            | Duration                    | Duration(milliseconds: 300)  | Provides time duration for auto scrolling                                            |
| disableBarrierInteraction | bool                        | false                        | If true then barrier interaction will be disabled.                                   |
| disableScaleAnimation     | bool                        | false                        | Disable scale transition for every showcases when it's being started and completed   |
| disableMovingAnimation    | bool                        | false                        | Disable bouncing/moving transition for every showcase widget                         |


## Properties of `Showcase` and `Showcase.withWidget`:

| Name                         | Type          | Default Behaviour                                                                    | Description                                                                                                                                                   | `Showcase` | `ShowCaseWidget` |
|------------------------------|---------------|--------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|------------------|
| key                          | GlobalKey     |                                                                                      | It is the global key for each showcase widget which must be unique.                                                                                           | ✅          | ✅                |
| child                        | Widget        |                                                                                      | The Widget that you want to be showcased                                                                                                                      | ✅          | ✅                |
| title                        | String?       |                                                                                      | Provides a title to tooltip                                                                                                                                   | ✅          |                  |
| description                  | String?       |                                                                                      | Provides a description to tooltip                                                                                                                             | ✅          |                  |
| container                    | Widget?       |                                                                                      | Allows to create custom tooltip widget.                                                                                                                       |            | ✅                |
| height                       | double?       |                                                                                      | Height of custom tooltip widget                                                                                                                               |            | ✅                |
| width                        | double?       |                                                                                      | Width of custom tooltip widget                                                                                                                                |            | ✅                |
| titleTextStyle               | TextStyle?    |                                                                                      | Text Style of tooltip title.                                                                                                                                  | ✅          |                  |
| descTextStyle                | TextStyle?    |                                                                                      | Text Style of tooltip description                                                                                                                             | ✅          |                  |
| titleAlignment               | TextAlign     | TextAlign.start                                                                      | Alignment of title                                                                                                                                            | ✅          |                  |
| descriptionAlignment         | TextAlign     | TextAlign.start                                                                      | Alignment of description                                                                                                                                      | ✅          |                  |
| onToolTipClick               | VoidCallback? |                                                                                      | Triggers when tooltip is being clicked.                                                                                                                       | ✅          |                  |
| onTargetClick                | VoidCallback? |                                                                                      | Triggers when target widget is being clicked                                                                                                                  | ✅          | ✅                |
| onTargetDoubleTap            | VoidCallback? |                                                                                      | Triggers when target widget is being double tapped                                                                                                            | ✅          | ✅                |
| onTargetLongPress            | VoidCallback? |                                                                                      | Triggers when target widget is being long pressed                                                                                                             | ✅          | ✅                |
| targetShapeBorder            | ShapeBorder   | `const RoundedRectangleBorder( borderRadius: BorderRadius.all( Radius.circular(8)))` | If `targetBorderRadius` param is not provided then it applies shape border to target widget                                                                   | ✅          | ✅                |
| targetBorderRadius           | BorderRadius? |                                                                                      | Border radius of target widget                                                                                                                                | ✅          | ✅                |
| tooltipBorderRadius          | BorderRadius? | BorderRadius.circular(8.0)                                                           | Border radius of Tooltip                                                                                                                                      | ✅          |                  |
| blurValue                    | double?       | `ShowCaseWidget.blurValue`                                                           | Gaussian blur effect of overlay                                                                                                                               | ✅          | ✅                |
| tooltipPadding               | EdgeInsets    | EdgeInsets.symmetric(vertical: 8, horizontal: 8)                                     | Padding of tooltip content                                                                                                                                    | ✅          |                  |
| targetPadding                | EdgeInsets    | EdgeInsets.zero                                                                      | Padding of highlighted part of widget of overlay                                                                                                              | ✅          | ✅                |
| overlayOpacity               | double        | 0.75                                                                                 | Applies opacity to overlay                                                                                                                                    | ✅          | ✅                |
| overlayColor                 | Color         | Colors.black45                                                                       | Color of overlay Layer                                                                                                                                        | ✅          | ✅                |
| tooltipBackgroundColor       | Color         | Colors.white                                                                         | Color of tooltip widget of showcase                                                                                                                           | ✅          |                  |
| textColor                    | Color         | Colors.black                                                                         | Color of tooltip text                                                                                                                                         | ✅          |                  |
| scrollLoadingWidget          | Widget        | `CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))`        | When autoScroll is enabled then this widget that will be display on overlay until active showcase is visible to viewport                                      | ✅          | ✅                |
| movingAnimationDuration      | Duration      | Duration(milliseconds: 2000)                                                         | The duration of time this moving animation should last.                                                                                                       | ✅          | ✅                |
| showArrow                    | bool          | true                                                                                 | Shows tooltip with arrow                                                                                                                                      | ✅          |                  |
| disableDefaultTargetGestures | bool          | false                                                                                | If `disableDefaultTargetGestures` parameter is true then `onTargetClick`, `onTargetDoubleTap`, `onTargetLongPress` and `disposeOnTap` parameter will not work | ✅          | ✅                |
| disposeOnTap                 | bool?         | false                                                                                | Allows to dispose active showcase on targetTap or on tooltip tap                                                                                              | ✅          | ✅                |
| disableMovingAnimation       | bool?         | `ShowCaseWidget.disableMovingAnimation`                                              | Disable bouncing/moving transition                                                                                                                            | ✅          | ✅                |
| disableScaleAnimation        | bool?         | `ShowCaseWidget.disableScaleAnimation`                                               | Disable scale transition when showcase is being started and completed                                                                                         | ✅          | ✅                |
| scaleAnimationDuration       | Duration      | Duration(milliseconds: 300)                                                          | The duration of time this scale animation should last.                                                                                                        | ✅          | ✅                |
| scaleAnimationCurve          | Curve         | Curves.easeIn                                                                        | The curve to use in the forward direction  for animation.                                                                                                     | ✅          | ✅                |
| scaleAnimationAlignment      | Alignment?    |                                                                                      | The alignment of the origin of the coordinate system in which the scale takes place, relative to the size of the box.                                         | ✅          | ✅                |


## How to use

Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.

## Scrolling to active showcase

Scrolling to active showcase feature will not work properly in scroll views that renders widgets on demand(ex, ListView, GridView).

In order to scroll to a widget it needs to be attached with widget tree. So, If you are using a scrollview that renders widgets on demand, it is possible that the widget on which showcase is applied is not attached in widget tree. So, flutter won't be able to scroll to that widget.

So, If you want to make a scroll view that contains less number of children widget then prefer to use SingleChildScrollView.

If using SingleChildScrollView is not an option, then you can assign a ScrollController to that scrollview and manually scroll to the position where showcase widget gets rendered. You can add that code in onStart method of `ShowCaseWidget`.

Example,

```dart
// This controller will be assigned to respected sctollview.
final _controller = ScrollController();

ShowCaseWidget(
  onStart: (index, key) {
    if(index == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
       // If showcase widget is at offset 1000 in the listview.
       // If you don't know the exact position of the showcase widget,
       // You can provide nearest possible location.
       // 
       // In this case providing 990 instead of 1000 will work as well.
        _controller.jumpTo(1000);
      });
    }
  },
);
```

## Enable Auto Scrolling
By default, auto-scrolling behavior is off, you can enable it by setting ``enableAutoScroll`` flag to true in ``showCaseWidget``.
```dart
ShowCaseWidget(
  enableAutoScroll: true,
);
```

## Main Contributors

<table>
  <tr>
    <td align="center"><a href="https://github.com/birjuvachhani"><img src="https://avatars.githubusercontent.com/u/20423471?s=100" width="100px;" alt=""/><br /><sub><b>Birju Vachhani</b></sub></a></td>
    <td align="center"><a href="https://github.com/DevarshRanpara"><img src="https://avatars.githubusercontent.com/u/26064415?s=100" width="100px;" alt=""/><br /><sub><b>Devarsh Ranpara</b></sub></a></td>
    <td align="center"><a href="https://github.com/AnkitPanchal10"><img src="https://avatars.githubusercontent.com/u/38405884?s=100" width="100px;" alt=""/><br /><sub><b>Ankit Panchal</b></sub></a></td>
    <td align="center"><a href="https://github.com/Kashifalaliwala"><img src="https://avatars.githubusercontent.com/u/30998350?s=100" width="100px;" alt=""/><br /><sub><b>Kashifa Laliwala</b></sub></a></td>
     <td align="center"><a href="https://github.com/vatsaltanna"><img src="https://avatars.githubusercontent.com/u/25323183?s=100" width="100px;" alt=""/><br /><sub><b>Vatsal Tanna</b></sub></a></td>
     <td align="center"><a href="https://github.com/sanket-simform"><img src="https://avatars.githubusercontent.com/u/65167856?v=4" width="100px;" alt=""/><br /><sub><b>Sanket Kachhela</b></sub></a></td>
     <td align="center"><a href="https://github.com/ParthBaraiya"><img src="https://avatars.githubusercontent.com/u/36261739?v=4" width="100px;" alt=""/><br /><sub><b>Parth Baraiya</b></sub></a></td>
     <td align="center"><a href="https://github.com/ShwetaChauhan18"><img src="https://avatars.githubusercontent.com/u/34509457" width="80px;" alt=""/><br /><sub><b>Shweta Chauhan</b></sub></a></td>
     <td align="center"><a href="https://github.com/MehulKK"><img src="https://avatars.githubusercontent.com/u/60209725?s=100" width="100px;" alt=""/><br /><sub><b>Mehul Kabaria</b></sub></a></td>
     <td align="center"><a href="https://github.com/DhavalRKansara"><img src="https://avatars.githubusercontent.com/u/44993081?v=4" width="100px;" alt=""/><br /><sub><b>Dhaval Kansara</b></sub></a></td>
     <td align="center"><a href="https://github.com/HappyMakadiyaS"><img src="https://avatars.githubusercontent.com/u/97177197?v=4" width="100px;" alt=""/><br /><sub><b>Happy Makadiya</b></sub></a></td>
  </tr>
</table>


## License

```text
MIT License

Copyright (c) 2021 Simform Solutions

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
