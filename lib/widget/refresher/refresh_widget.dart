import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// The [RefreshWidget] allow to refresh and load more data.
class RefreshWidget extends StatelessWidget {
  const RefreshWidget(
      {Key key,
      @required this.onRefresh,
      @required this.onLoading,
      @required this.refreshController,
      @required this.child})
      : super(key: key);

  final Widget child;
  final Function onRefresh;
  final Function onLoading;
  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      child: child,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullDown: true,
      header: const ClassicHeader(
          completeIcon: null,
          idleIcon: null,
          releaseIcon: null,
          releaseText: '',
          refreshingText: '',
          completeText: '',
          failedText: '',
          idleText: ''),
      footer: const ClassicFooter(
        idleText: '',
        loadingText: '',
        canLoadingText: '',
        idleIcon: SizedBox(),
      ),
      enablePullUp: true,
      controller: refreshController);
  }
}
