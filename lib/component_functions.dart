import 'package:appweb3603/DIContainer.dart';
import 'package:flutter/cupertino.dart';

/*
 * As funções são injetadas em page_component em globalDIContainer.
 * Necessário usar [
 *    with AutomaticKeepAliveClientMixin {
 *    @override
 *    bool get wantKeepAlive => true;
 *    ... 
 * ]
 * para funcionar
*/


/*
 *
*/
void showFloatScreen({String title = "", Widget? child, Color? backgroundColor, Color? headerItemColor}) {
  Function lshowFloatScreen = globalDIContainer.get('showFloatScreen') as Function;
  lshowFloatScreen(title: title, child: child, backgroundColor: backgroundColor, headerItemColor: headerItemColor);
}

void hideFloatScreen() {
  Function lhideFloatScreen = globalDIContainer.get('hideFloatScreen') as Function;
  lhideFloatScreen();
}

/*
 *
*/
void showNotification({String message = "", String type = "warning"}) {
  Function lshowNotification = globalDIContainer.get('showNotification') as Function;
  lshowNotification(message: message, type: type);
}

/*
 *
*/
void showLoading() {
  Function lshowLoading = globalDIContainer.get('showLoading') as Function;
  lshowLoading();
}

/*
 *
*/
void hideLoading() {
  Function lhideLoading = globalDIContainer.get('hideLoading') as Function;
  lhideLoading();
}

void showAlert({String title = "", Function? callback, String? cancelTitle, String? successTitle, Function? cancelCallback, String message = "", IconData? icon = CupertinoIcons.check_mark}) {
  Function lshowAlert = globalDIContainer.get('showAlert') as Function;
  lshowAlert(
    title: title,
    message: message,
    callback: callback,
    cancelCallback: cancelCallback,
    cancelTitle: cancelTitle,
    successTitle: successTitle,
    icon: icon,
  );
}

void hideAlert() {
  Function lhideAlert = globalDIContainer.get('hideAlert') as Function;
  lhideAlert();
}