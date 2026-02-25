import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_cafe/get_all_cafe_cubit.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/features/home_screen/screen/product_detail_screen.dart';
import 'package:zeggo_cus/widgets/custom_product_card.dart';

class CafeView extends StatefulWidget {
  const CafeView({super.key});

  @override
  State<CafeView> createState() => _CafeViewState();
}

class _CafeViewState extends State<CafeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF7E8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text("Zeggo Cafe"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<GetAllCafeCubit, GetAllCafeState>(
          builder: (context, state) {
            if (state is GetAllCafeLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GetAllCafeLoadedState) {
              return GridView.builder(
                itemCount: state.model.data?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: .49,
                ),
                itemBuilder: (_, index) {
                  final p = state.model.data?[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(id: p?.id ?? "")));
                    },
                    child: CustomProductCard(data: p ?? Datum()),
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
