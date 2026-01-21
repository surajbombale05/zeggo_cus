import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zeggo_cus/constants/app_init.dart';
import 'package:zeggo_cus/constants/app_theme.dart';
import 'package:zeggo_cus/features/auth/bloc/send_otp/send_otp_cubit.dart';
import 'package:zeggo_cus/features/auth/bloc/verify_otp/verify_otp_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_banner/get_all_banner_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_cafe/get_all_cafe_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_product_by_cat_id_and_sub_id/get_all_product_by_catid_and_subcatid_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_trending/get_all_trending_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_product_by_id/get_product_by_id_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/like_toogle/like_toogle_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/delete_address/delete_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/post_address/post_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/update_address/update_address_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/delete_profile/delete_profile_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_all_wishlist/get_all_wishlist_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_profile/get_profile_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/post_wishlist/post_wishlist_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/update_profile/update_profile_cubit.dart';
import 'package:zeggo_cus/features/splash_screen/splash_screen_view.dart';
import 'package:zeggo_cus/firebase_options.dart';
import 'package:zeggo_cus/utils/repo.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

String? firebasetoken;
String? userId;
Repository repository = Repository();

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await AppInit.init();
    await LocalStorageUtils.init().then((e) {
      userId = LocalStorageUtils.getUserId();
    });

    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>(
      'cartBox',
    ).then((e) => {print("Box Open Sucessfully")}).onError((e, stk) => {print("Error to Open $e $stk")});
  } catch (e, stk) {
    log("-------- $e $stk");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllCategoryCubit>(create: (context) => GetAllCategoryCubit()),
        BlocProvider<GetAllProductsCubit>(create: (context) => GetAllProductsCubit()),
        BlocProvider<GetAllBannerCubit>(create: (context) => GetAllBannerCubit()),
        BlocProvider<GetProductByIdCubit>(create: (context) => GetProductByIdCubit()),
        BlocProvider<SendOtpCubit>(create: (context) => SendOtpCubit()),
        BlocProvider<VerifyOtpCubit>(create: (context) => VerifyOtpCubit()),
        BlocProvider<GetProfileCubit>(create: (context) => GetProfileCubit()),
        BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit()),
        BlocProvider<DeleteProfileCubit>(create: (context) => DeleteProfileCubit()),
        BlocProvider<GetAllAddressCubit>(create: (context) => GetAllAddressCubit()),
        BlocProvider<PostAddressCubit>(create: (context) => PostAddressCubit()),
        BlocProvider<DeleteAddressCubit>(create: (context) => DeleteAddressCubit()),
        BlocProvider<UpdateAddressCubit>(create: (context) => UpdateAddressCubit()),
        BlocProvider<LikeToogleCubit>(create: (context) => LikeToogleCubit()),
        BlocProvider<GetAllTrendingCubit>(create: (context) => GetAllTrendingCubit()),
        BlocProvider<GetAllCafeCubit>(create: (context) => GetAllCafeCubit()),
        BlocProvider<GetAllProductByCatidAndSubcatidCubit>(create: (context) => GetAllProductByCatidAndSubcatidCubit()),
        BlocProvider<PostWishlistCubit>(create: (context) => PostWishlistCubit()),
        BlocProvider<GetAllWishlistCubit>(create: (context) => GetAllWishlistCubit()),
      ],

      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zeggo',
        theme: AppTheme().theme,
        home: SplashView(),
      ),
    );
  }
}
