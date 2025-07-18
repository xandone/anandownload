import 'package:anandownload/res/gaps.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';
import '../res/styles.dart';

/// @author: xiao
/// created on: 2025/7/18 14:20
/// description:

class LoadingTip extends StatelessWidget {
  final LoadingStatus? initStatus;
  final Widget? child;
  final Function? retryCallback;

  const LoadingTip({
    super.key,
    this.child,
    LoadingStatus? initStatus,
    this.retryCallback,
  }) : initStatus = initStatus ?? LoadingStatus.initial;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: constraints.maxWidth,
          minHeight: constraints.maxHeight,
        ),
        child: IntrinsicHeight(child: _generateStatusWidget()),
      );
    });
  }

  Widget _generateStatusWidget() {
    switch (initStatus) {
      case LoadingStatus.initial:
        return Container();
      case LoadingStatus.content:
        return child ?? Container();
      case LoadingStatus.loading:
        return _loading();
      case LoadingStatus.empty:
        return _empty();
      case LoadingStatus.disconnect:
        return _disconnect();
      case LoadingStatus.error:
        return _error();
      default:
        return Container();
    }
  }

// 加载中
  Widget _loading() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(
              backgroundColor: MyColors.btnColor,
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              strokeWidth: 3,
            )),
        Gaps.vGaps10,
        Text("加载中...",
            style: MyStyles.text_simple_tip_style)
      ],
    );
  }

// 暂无内容
  Widget _empty() {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Gaps.vGaps10,
      Text("暂无内容", style: MyStyles.text_simple_tip_style)
    ]);
  }

// 网络不可用
  Widget _disconnect() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Gaps.vGaps10,
      const Text("网络不可用", style: MyStyles.text_simple_tip_style),
      Gaps.vGaps10,
      ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: MyColors.btnColor, padding: EdgeInsets.zero),
        onPressed: () {
          retryCallback?.call();
        },
        child: const Text('刷新', style: MyStyles.text_simple_tip_style),
      )
    ]);
  }

// 加载失败
  Widget _error() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Gaps.vGaps10,
      const Text("加载失败", style: MyStyles.text_simple_tip_style),
      Gaps.vGaps10,
      ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: MyColors.btnColor, padding: EdgeInsets.zero),
        onPressed: () {
          retryCallback?.call();
        },
        child: const Text('刷新', style: MyStyles.text_simple_tip_style),
      )
    ]);
  }
}

enum LoadingStatus {
  initial,
  content,
  loading,
  empty,
  disconnect,
  error,
}
