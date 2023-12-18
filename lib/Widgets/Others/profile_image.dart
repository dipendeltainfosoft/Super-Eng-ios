// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../Configuration/ImageConfig.dart';
// import '../../Configuration/PrefsConfig.dart';
// import '../../Controllers/Others/dashboard_controller.dart';
//
// class ProfileAvatar extends ConsumerWidget {
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//    return Gwet(
//      child: CircleAvatar(
//         backgroundColor: Colors.white,
//         backgroundImage: PrefsConfig.getProfilePic().isNotEmpty?NetworkImage(PrefsConfig.getProfilePic()):ref.watch(profileImageState).isNotEmpty? NetworkImage(ref.watch(profileImageState)):AssetImage(profileImage),
//         radius: 25,
//       ),
//    );
//   }
// }
