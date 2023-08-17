import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarkhine/logic/cubits/cart_cubit.dart';
import 'package:tarkhine/logic/cubits/internet_cubit.dart';
import 'package:tarkhine/logic/cubits/order_cubit.dart';
import '../../../core/core.dart';
import '../../../logic/cubits/delivery_cubit.dart';
import '../../../common/common.dart';
import 'widgets/appbars.dart';
import '../../../logic/cubits/navigation_cubit.dart';
import 'widgets/bottom_navigation_bar_items.dart';
import 'widgets/screens.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DeliveryCubit(),
        ),
        BlocProvider(
          create: (_) => CartCubit(context.auth.user!),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => InternetCubit(),
        ),
        BlocProvider(
          create: (_) => OrderCubit(context.auth.user!),
        ),
      ],
      child: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case InternetDisconnectedState:
              showSnackbar(
                context,
                'اتصال اینترنت شما قطع شد، پس از اتصال مجدد لطفا صحفه را رفرش کنید.',
                SnackBarType.error,
              );
          }
        },
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: AppColor.white,
                appBar: appbars[(state as NavigationIndexState).index],
                body: state is NavigationLoadingState
                    ? const YxLoader().center
                    : screens[state.index],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: context.nav.changeIndex,
                  type: BottomNavigationBarType.fixed,
                  selectedLabelStyle:
                      const TextStyle(fontFamily: 'Estedad', fontSize: 10),
                  unselectedLabelStyle:
                      const TextStyle(fontFamily: 'Estedad', fontSize: 10),
                  items: bottomNavigationBarItems,
                ).sizedBox(height: 64),
              ),
            );
          },
        ),
      ),
    );
  }
}
