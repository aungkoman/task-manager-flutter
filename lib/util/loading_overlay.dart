import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog{
  static void show(BuildContext context){
    showDialog(
        context: context,
        builder: (_) => WillPopScope(
          onWillPop: () async => true,
          child: SimpleDialog(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  // color: Colors.red,
                  child: SpinKitRipple(
                    color: Colors.white,
                  ),
                  //child: const CircularProgressIndicator()
                ),
              ),
              SizedBox(height: 10,),
              Center(child: Text("Loading...", style: TextStyle(color: Colors.white),))],
          ),
        )
    );
  }

  /**
   * The dialog route created by this method is pushed to the root navigator.
   * If the application has multiple Navigator objects,
   * it may be necessary to call Navigator.of(context, rootNavigator: true).pop(result)
   * to close the dialog rather just Navigator.pop(context, result).
   *
   * https://docs.flutter.io/flutter/material/showDialog.html
   */
  static void hide(BuildContext context){
    //Navigator.pop(context);
    Navigator.of(context, rootNavigator: true).pop();
  }
}