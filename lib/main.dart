import 'package:duke_kanban/Views/Dashboard/Dashboard.dart';
import 'package:duke_kanban/Views/Department/DepartmentView.dart';
import 'package:duke_kanban/Views/Employee/EmployeeView.dart';
import 'package:duke_kanban/Views/Intro/SplashScreen.dart';
import 'package:duke_kanban/Views/Profile/ProfileScreen.dart';
import 'package:duke_kanban/Views/ReqApproval/ReqApprovalView.dart';
import 'package:duke_kanban/Views/Search/SearchList.dart';
import 'package:duke_kanban/Views/Task/RemarkList.dart';
import 'package:duke_kanban/Views/Task/TaskList.dart';
import 'package:duke_kanban/Views/TaskApproval/TaskApprovalView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'Configuration/PrefsConfig.dart';
import 'Views/Authentication/LoginScreen.dart';
import 'Views/Notification/NotificationScreen.dart';
import 'Views/Task/EditTask.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsConfig.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
      MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        builder: (context, child) =>
            ResponsiveBreakpoints.builder(
              child: child,
              breakpoints: [
                Breakpoint(start: 0, end: 450, name: MOBILE),
                Breakpoint(start: 451, end: 800, name: TABLET),
                Breakpoint(start: 801, end: 1920, name: DESKTOP),
                Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.rightToLeft,
        getPages: [
          GetPage(name: '/login', page: () => LoginScreen()),
          // GetPage(name: '/profile', page: () => ProfileScreen()),
          GetPage(name: '/deptList', page: () => DepartmentView()),
          GetPage(name: '/taskList', page: () => TaskList()),
          GetPage(name: '/taskEdit', page: () => TaskEditScreen()),
          GetPage(name: '/empList', page: () => EmployeeView()),
          GetPage(name: '/notification', page: () => NotificationScreen()),
          GetPage(name: '/taskAppr', page: () => TaskApprovalScreen()),
          GetPage(name: '/reqAppr', page: () => ReqApprovalScreen()),
          GetPage(name: '/remark', page: () => RemarksListUI()),
          GetPage(name: '/dashboard', page: () => DashboardPage()),
          GetPage(name: '/search', page: () => SearchUI()),
        ],
        theme: ThemeData(
          primaryColor: ColorConfig.primaryAppColor,
          scaffoldBackgroundColor: Colors.white,
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStatePropertyAll(
              ColorConfig.primaryAppColor,
            ),
          ),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: GoogleFonts.gothicA1TextTheme(),
        ),
        title: "Super Eng Kanban 3.0",
        home: PrefsConfig.getUserId() == "" ? SplashScreen() : DashboardPage());
  }
}
