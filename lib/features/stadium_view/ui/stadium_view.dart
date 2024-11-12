import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hero_animation/features/home/models/home_stadium_data_model.dart';
import 'package:hero_animation/features/stadium_view/bloc/stadium_view_bloc.dart';

class StadiumViewPage extends StatefulWidget {
  final StadiumDataModel stadiumDataModel;
  const StadiumViewPage({super.key, required this.stadiumDataModel});
  @override
  State<StadiumViewPage> createState() => _StadiumViewPageState();
}

class _StadiumViewPageState extends State<StadiumViewPage> {
  StadiumViewBloc stadiumViewBloc = StadiumViewBloc();
  @override
  void initState() {
    stadiumViewBloc.add(StadiumViewInitialEvent());
    super.initState();
  }

  bool isClicked = false;
  void toggleStatus() {
    setState(() {
      isClicked = !isClicked;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Liked Stadium History")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<StadiumViewBloc, StadiumViewState>(
        bloc: stadiumViewBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is StadiumViewActionState,
        buildWhen: (previous, current) => current is! StadiumViewActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case StadiumClickedSuccessState _:
              final successtate = state as StadiumClickedSuccessState;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.stadiumDataModel.imageUrl!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                  DraggableScrollableSheet(
                    initialChildSize: 0.3,
                    minChildSize: 0.3,
                    maxChildSize: 1.0,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24.0),
                            topRight: Radius.circular(24.0),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 5.0,
                            ),
                          ],
                        ),
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.stadiumDataModel.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        'Opened: ${widget.stadiumDataModel.openedYear}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(
                                        widget.stadiumDataModel.description,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          height: 1.5,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: isClicked
                                          ? const Icon(Icons.favorite)
                                          : const Icon(
                                              Icons.favorite_border_outlined),
                                      color: Colors.redAccent,
                                      onPressed: toggleStatus,
                                      iconSize: 28.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Divider(color: Colors.grey[300], thickness: 1),
                            const SizedBox(height: 10),

                            // Additional sections or information can go here
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            default:
              return const Center(
                  child: Text("Cannot fetch the clicked stadium"));
          }
        },
      ),
    );
  }
}
