import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saghi/layout_un_registerd/layout_un_registerd.dart';
import 'package:saghi/screens/auth/on_boarding_screen/cubit/onboarding_cubit.dart';
import 'package:saghi/screens/darwer/guide_screen/cubit/guideliness_cubit.dart';
import 'package:saghi/shared/helper/mangers/colors.dart';
import 'package:saghi/shared/helper/mangers/constants.dart';
import 'package:saghi/shared/helper/mangers/size_config.dart';
import 'package:saghi/shared/helper/methods.dart';
import 'package:saghi/shared/services/local/cache_helper.dart';
import 'package:saghi/widget/app_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widget/custom_page_view.dart';

class OnBoardingScreen extends StatelessWidget {
  var boardController = PageController(initialPage: 0);
  int currentPage = 0;

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfigManger().init(context);
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardingCubit cubit = OnboardingCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Column(
                children: [
                  SizedBox(height: SizeConfigManger.bodyHeight * .04),
                  AppText(
                      text: "Guidelines",
                      color: ColorsManger.darkPrimary,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      textSize: 30)
                ],
              ),
              actions: [
                cubit.currentPage != 3
                    ? IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.help_center, color: ColorsManger.grey))
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[300]),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.help_center,
                                color: ColorsManger.darkPrimary)),
                      )
              ],
            ),
            body: Center(
              child: Container(
                height: SizeConfigManger.bodyHeight * .7,
                width: SizeConfigManger.screenWidth * .9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsManger.darkPrimary),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfigManger.bodyHeight * .1),
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: (index) {
                          print(index);
                          if (index != 3) {
                            cubit.changeCurrentIndex(index);
                          }
                          if (index == splashData.length - 1) {
                            OnboardingCubit.get(context)
                                .changePageViewState(true, index);
                          } else {
                            OnboardingCubit.get(context)
                                .changePageViewState(false, index);
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                        controller: boardController,
                        itemCount: splashData.length,
                        itemBuilder: (context, index) =>
                            CustomPageViewOnBoarding(
                                title: "${splashData[index]["title"]}",
                                text: "${splashData[index]["details"]}"),
                      ),
                    ),
                    SizedBox(height: SizeConfigManger.bodyHeight * .04),
                    SmoothPageIndicator(
                      controller: boardController,
                      count: splashData.length,
                      effect: SlideEffect(
                        dotColor: Colors.grey,
                        activeDotColor: ColorsManger.darkPrimary,
                        dotHeight: 10,
                        //  expansionFactor: 4,
                        dotWidth: 50,
                        spacing: 5.0,
                      ),
                    ),
                    SizedBox(height: SizeConfigManger.bodyHeight * .04),
                    cubit.currentPage == 3
                        ? InkWell(
                            onTap: () async {
                              await CachedHelper.saveBool(
                                  key: ConstantsManger.onBoadring, value: true);
                              navigateToAndFinish(
                                  context, const LayoutUnRegisterd());
                            },
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Container(
                                width: SizeConfigManger.screenWidth * .3,
                                height: SizeConfigManger.bodyHeight * .08,
                                decoration: BoxDecoration(
                                    color: ColorsManger.darkPrimary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: AppText(
                                  text: "Close",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              boardController.nextPage(
                                  duration: const Duration(
                                    milliseconds: 750,
                                  ),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            },
                            child: Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: Container(
                                width: SizeConfigManger.screenWidth * .3,
                                height: SizeConfigManger.bodyHeight * .08,
                                decoration: BoxDecoration(
                                    color: ColorsManger.darkPrimary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: AppText(
                                  text: "Skip",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Visibility(
              visible: cubit.currentPage != 4,
              child: BottomNavigationBar(
                items: cubit.bottomNavItems,
                currentIndex: cubit.currentIndex,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, String>> splashData = [
    {
      "title": "Text to speech icon",
      "details":
          "Anda akan dibawa ke halaman Text to Speech, disana Anda dapat menulis teks yang akan diubah menjadi audio pidato."
    },
    {
      "title": "Emosound icon",
      "details":
          "Anda akan dibawa ke halaman beranda, di sana Anda dapat merekam audio secara real-time atau mengunggah file audio yang akan diubah menjadi teks."
    },
    {
      "title": "Account icon",
      "details":
          "Anda akan dibawa ke halaman akun pribadi Anda (atau halaman masuk/mendaftar), di sana Anda dapat mengedit profil Anda dan memeriksa hasil Keep Anda."
    },
    {
      "title": "Help Icon ",
      "details":
          "Anda akan dibawa melalui tur tentang cara menggunakan halaman yang Anda buka."
    },
  ];
}
