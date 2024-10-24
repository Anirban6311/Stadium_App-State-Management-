import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_animation/features/planned/bloc/planned_bloc.dart';
import 'package:hero_animation/features/planned/ui/planned_tile_widget.dart';

class PlannedPage extends StatefulWidget {
  const PlannedPage({super.key});

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  PlannedBloc plannedBloc = PlannedBloc();
  @override
  void initState() {
    plannedBloc.add(PlannedInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planned"),
      ),
      body: BlocConsumer<PlannedBloc, PlannedState>(
        bloc: plannedBloc,
        listener: (context, state) {},
        //i want to listen when there is actioned state (such as showing of snackbar)
        listenWhen: (previous, current) => current is PlannedActionState,
        buildWhen: (previous, current) => current is! PlannedActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PlannedSuccessState:
              final successState = state as PlannedSuccessState;
              return ListView.builder(
                itemCount: successState.plannedStadiums.length,
                itemBuilder: (context, index) {
                  return PlannedTileWidget(
                    plannedBloc: plannedBloc,
                    stadiumDataModel: successState.plannedStadiums[index],
                  );
                },
              );
            default:
              return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }
}
