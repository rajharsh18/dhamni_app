import 'package:dhamni/src/constants/colors.dart';
import 'package:dhamni/src/constants/image_strings.dart';
import 'package:dhamni/src/constants/sizes.dart';
import 'package:dhamni/src/constants/text_strings.dart';
import 'package:dhamni/src/features/authentication/models/user_model.dart';
import 'package:dhamni/src/features/core/controllers/profile_controller.dart';
import 'package:dhamni/src/features/core/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final txtTheme = Theme.of(context).textTheme;
    final controller = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // leading: Icon(
          //   Icons.menu,
          //   //For Dark Color
          //   color: isDark ? tWhiteColor : tDarkColor,
          // ),
          title:
              Text(tAppName, style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                //For Dark Color
                // color: isDark ? tSecondaryColor : tCardBgColor,
                color: tCardBgColor,
              ),
              child: IconButton(
                  onPressed: () => Get.to(() => ProfileScreen()),
                  icon: const Image(image: AssetImage(tUserProfileImage))),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData.fullName,
                          style: txtTheme.headlineMedium,
                        ),
                        Text(
                          tDashboardSubTitle,
                          style: txtTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: tDashboardPadding,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(left: BorderSide(width: 4))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tDashboardSearch,
                                  style: txtTheme.headlineMedium?.apply(
                                      color: Colors.grey.withOpacity(0.5))),
                              const Icon(Icons.mic, size: 25),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: tDarkColor),
                                  child: Center(
                                    child: Text(
                                      "JS",
                                      style: txtTheme.headlineSmall
                                          ?.apply(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return Center(child: Text('Sonething went Wrong !!!'));
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
