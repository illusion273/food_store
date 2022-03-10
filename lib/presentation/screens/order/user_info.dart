import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/app/app_bloc.dart';
import 'package:food_store/logic/blocs/cart/cart_bloc.dart';
import 'package:go_router/go_router.dart';

import 'user_data_tile.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 12),
              BlocBuilder<AppBloc, AppState>(
                builder: (context, state) {
                  return UserDataTile(
                    title: "Location",
                    subtitle: state.prefLocation?.address ?? "",
                    subtitlePlus: state.prefLocation?.details ?? "",
                    icon: Icons.gps_fixed,
                    onTap: () => context.push('/location_choose'),
                  );
                },
              ),
              const SizedBox(height: 12),
              UserDataTile(
                title: "Payment method",
                subtitle: "Debit Card",
                subtitlePlus: "4444333322221111",
                icon: Icons.credit_card,
                onTap: () => () {},
              ),
              const SizedBox(height: 20),
            ]),
          );
        },
      ),
    );
  }
}
