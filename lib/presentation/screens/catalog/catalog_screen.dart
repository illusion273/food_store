// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/catalog/catalog_bloc.dart';
import 'package:food_store/presentation/screens/catalog/cart_button.dart';
import 'package:food_store/presentation/screens/catalog/animated_app_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../logic/blocs/app/app_bloc.dart';
import '../../../logic/utilities/bar_cubit.dart';
import 'catalog_tile.dart';
import 'circular_button.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen>
    with TickerProviderStateMixin {
  final List<GlobalKey> keys = [];
  final List<double> offsets = [];
  late final ScrollController _scrollController;
  late TabController _tabController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    _scrollController.addListener(() {
      for (int i = _tabController.length - topSlivers; i >= 0; i--) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _tabController.animateTo(_tabController.length - 1);
          break;
        } else if (_scrollController.offset + 200 >= offsets[i]) {
          _tabController.animateTo(i);
          break;
        }
      }
    });

    _scrollController.addListener(() {
      final barState = context.read<AnimBarCubit>().state;
      if (_scrollController.offset > 120 && !barState) {
        context.read<AnimBarCubit>().animate();
      } else if (_scrollController.offset <= 120 && barState) {
        context.read<AnimBarCubit>().animate();
      }
    });

    _scrollController.addListener(() {
      if (_focusNode.hasFocus) _focusNode.unfocus();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _focusNode.unfocus();
    super.dispose();
  }

  void scrollSync(int length) {
    keys.clear();
    offsets.clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (var key in keys) {
        var renderSliver =
            key.currentContext!.findRenderObject() as RenderSliver;
        var x = renderSliver.constraints.precedingScrollExtent;
        offsets.add(x);
      }
    });
    _tabController = TabController(length: length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          scrollSync(state.catalog.catalogTiles.length);
          return Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: List.generate(
                    state.catalog.catalogTiles.length + topSlivers, (i) {
                  if (i == 0) {
                    return SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: xPadding,
                          top: MediaQuery.of(context).padding.top + 24,
                          right: xPadding,
                        ),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Good Evening!",
                                      style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 10),
                                  BlocBuilder<AppBloc, AppState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: () =>
                                            context.push('/location_choose'),
                                        child: Text(
                                          state.prefLocation?.address ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            CircularButton(
                              iconData: Icons.person,
                              onTap: () => context.push('/profile'),
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (i == 1) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: xPadding, vertical: 16),
                        child: TextField(
                          focusNode: _focusNode,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search, size: 25),
                            hintText: "Search anything",
                          ),
                          onSubmitted: (value) => context
                              .read<CatalogBloc>()
                              .add(CatalogSearched(value.toLowerCase())),
                        ),
                      ),
                    );
                  } else {
                    var key = GlobalKey();
                    keys.add(key);
                    return SliverPadding(
                      padding: const EdgeInsets.only(
                          left: xPadding, right: xPadding, bottom: 10),
                      sliver: SliverList(
                        key: key,
                        delegate: SliverChildBuilderDelegate(
                          (_, j) {
                            if (j == 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.catalog.catalogTiles.keys
                                        .elementAt(i - topSlivers),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Divider(
                                      thickness: 1, color: Colors.black),
                                ],
                              );
                            } else {
                              final item = state.catalog.catalogTiles.values
                                  .elementAt(i - topSlivers)[j - 1];
                              return CatalogTile(
                                img: item.img,
                                title: item.title,
                                description: item.description,
                                price: item.basePrice,
                                onTap: () {
                                  context.go('/catalog/${item.id}',
                                      extra: item);
                                },
                              );
                            }
                          },
                          childCount: state.catalog.catalogTiles.values
                                  .elementAt(i - topSlivers)
                                  .length +
                              1,
                        ),
                      ),
                    );
                  }
                }),
              ),
              AnimatedAppBar(
                focusNode: _focusNode,
                tabController: _tabController,
                scrollController: _scrollController,
                offsets: offsets,
              ),
              const CartButton(),
            ],
          );
        },
      ),
    );
  }
}

const double xPadding = 16;

/// Sliver count excluding SliverList
const int topSlivers = 2;

// _scrollController.addListener((() {
    //   print("PaintOrigin" + y.geometry!.paintOrigin.toString() + "\n");
    //   print("LayoutExtend" + y.geometry!.layoutExtent.toString() + "\n");
    //   print("paintExtent" + y.geometry!.paintExtent.toString() + "\n");
    //   print("maxPaintExtent" + y.geometry!.maxPaintExtent.toString() + "\n");
    //   print("scrollExtent" + y.geometry!.scrollExtent.toString() + "\n");
    //   print("cacheExtent" + y.geometry!.cacheExtent.toString() + "\n");
    //   print("scrollOffsetCorrection" +
    //       y.geometry!.scrollOffsetCorrection.toString() +
    //       "\n");
    //   print("hitTestExtent" + y.geometry!.hitTestExtent.toString() + "\n");
    //   print("maxScrollObstructionExtent" +
    //       y.geometry!.maxScrollObstructionExtent.toString() +
    //       "\n");
    //   print("visible" + y.geometry!.visible.toString() + "\n");
    //   //print("visible" +  "\n");
    //   print("\n");
    // }));