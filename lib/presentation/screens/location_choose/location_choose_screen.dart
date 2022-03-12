import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_store/logic/blocs/app/app_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationChooseScreen extends StatelessWidget {
  const LocationChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              return ListTile(
                horizontalTitleGap: 4.5,
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(
                    state.user.locations[index] == state.selectedLocation
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    size: 28,
                  ),
                ),
                title: Text(state.user.locations[index].address),
                subtitle: Text(state.user.locations[index].details),
                onTap: () {
                  context
                      .read<AppBloc>()
                      .add(AppSelectedLocationSet(state.user.locations[index]));
                  context.pop();
                },
              );
            }),
            itemCount: state.user.locations.length,
          );
        },
      ),
      bottomNavigationBar: TextButton.icon(
        style: TextButton.styleFrom(
            alignment: const Alignment(-0.96, 0),
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add),
        label: const Text("Add new address"),
        onPressed: () => context.push('/location_search'),
      ),
      // Container(
      //   //padding: const EdgeInsets.symmetric(horizontal: 20),
      //   decoration: const BoxDecoration(
      //     color: Colors.yellow,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Color.fromARGB(255, 179, 178, 178),
      //         blurRadius: 4,
      //         offset: Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   child: TextButton.icon(
      //     icon: const Icon(Icons.add),
      //     label: const Text("Add new address"),
      //     onPressed: () {},
      //   ),
      // ),
    );
  }
}
