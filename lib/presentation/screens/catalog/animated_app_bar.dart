import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/app/app_bloc.dart';
import 'package:food_store/logic/blocs/catalog/catalog_bloc.dart';
import 'package:food_store/logic/utilities/bar_cubit.dart';
import 'package:food_store/presentation/screens/catalog/circular_button.dart';
import 'package:go_router/go_router.dart';

class AnimatedAppBar extends StatefulWidget {
  const AnimatedAppBar({
    Key? key,
    required this.focusNode,
    required this.tabController,
    required this.scrollController,
    required this.offsets,
  }) : super(key: key);

  final FocusNode focusNode;
  final TabController tabController;
  final ScrollController scrollController;
  final List<double> offsets;

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

const int animDurationSlow = 500;

class _AnimatedAppBarState extends State<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animControlller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animControlller = AnimationController(
      duration: const Duration(milliseconds: animDurationSlow),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animControlller,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //state ? _animControlller.forward() : _animControlller.reverse();
    return BlocListener<AnimBarCubit, bool>(
      listener: (context, barState) {
        barState ? _animControlller.forward() : _animControlller.reverse();
      },
      child: SlideTransition(
        position: _offsetAnimation,
        child: SizedBox(
          height: kToolbarHeight + 46 + MediaQuery.of(context).padding.top,
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              return AppBar(
                //backgroundColor: Colors.white24,
                centerTitle: true,
                leading: Container(
                  margin: const EdgeInsets.all(7),
                  child: CircularButton(
                    iconData: Icons.person,
                    onTap: () => context.push('/profile'),
                  ),
                ),
                title: BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => context.push('/location_choose'),
                      child: Text(state.prefLocation?.address ?? "",
                          style: Theme.of(context).textTheme.titleMedium),
                    );
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircularButton(
                        iconData: Icons.search,
                        onTap: () async {
                          widget.scrollController.jumpTo(50);
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          widget.focusNode.requestFocus();
                        }),
                  ),
                ],
                bottom: TabBar(
                  controller: widget.tabController,
                  onTap: (value) => value == widget.tabController.length - 1
                      ? widget.scrollController.jumpTo(
                          widget.scrollController.position.maxScrollExtent)
                      : widget.scrollController
                          .jumpTo(widget.offsets[widget.tabController.index]),
                  isScrollable: true,
                  tabs:
                      List.generate(state.catalog.catalogTiles.length, (index) {
                    return Tab(
                        text: state.catalog.catalogTiles.keys.elementAt(index));
                  }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
