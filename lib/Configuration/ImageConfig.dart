import 'package:flutter/material.dart';

class ImageConfig {
  static Widget fromAsset(
      {@required String imagePath,
      double size,
      double width,
      BoxFit fit,
      Color color}) {
    return Image.asset(
      imagePath,
      height: size,
      width: width,
      fit: fit,
      color: color,
    );
  }

  static Widget fromNetwork(
      {String imagePath, double size, double width, BoxFit fit, Color color}) {
    return Image.network(
      imagePath,
      height: size,
      width: width,
      fit: fit,
      color: color,
    );
  }
}

// ! Images
String applogoImage = "assets/images/applogo.png";
String logoImage = "assets/images/logo.png";
String paymentImage = "assets/images/payment.png";
String loginImage = "assets/images/login2.png";
String ierpImage = "assets/images/ierp.png";
String deltaImage = "assets/images/deltafooter.png";
String deltaLogo = "assets/images/deltalogo.png";
String profileImage = "assets/images/profile.png";
String bankImage = "assets/images/bank.png";
String empImage = "assets/images/emp.png";
String taskImage = "assets/images/task.png";
String bellImage = "assets/images/bell.png";
String userImage = "assets/images/user.png";
String stampImage = "assets/images/stamp.png";
String dueImage = "assets/images/due.png";

String cameraImage = "assets/images/camera.png";
String documentImage = "assets/images/document.png";
String galleryImage = "assets/images/gallery.png";
String workImage = "assets/images/work.png";
String pendingImage = "assets/images/pending.png";
String doneImage = "assets/images/done.png";
String singleTickIcon = "assets/images/signle.png";
String doubleTickIcon = "assets/images/doubletickdark.png";
String doubleTickOrangeIcon = "assets/images/double_check_orange.png";
String greenDotIcon = "assets/images/green_dot.png";

//! Icons
String prTypeIcon = "assets/icons/prtype.png";
String prNoIcon = "assets/icons/prno.png";
String calendarIcon = "assets/icons/calendar.png";
String commentIcon = "assets/icons/comment.png";
String rupeeIcon = "assets/icons/rupee.png";
String pdfIcon = "assets/icons/pdf.png";
String teamWorkIcon = "assets/icons/teamwork.png";
String accIcon = "assets/icons/account.png";
String gstIcon = "assets/icons/gst.png";
String hodIcon = "assets/icons/hod.png";
String bankIcon = "assets/icons/bank.png";
String payIcon = "assets/icons/payment.png";
String ledgerIcon = "assets/icons/ledger.png";
String xlsIcon = "assets/icons/xls.png";
String teamIcon = "assets/icons/team.png";
String userIcon = "assets/images/user1.png";
String moreIcon = "assets/images/more.png";
String sendIcon = "assets/images/send.png";
String downArrowIcon = "assets/images/down_arrow.png";
String buildIcon = "assets/icons/build.png";
String allTaskIcon = "assets/icons/listing.png";
