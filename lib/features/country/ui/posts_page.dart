import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/posts_bloc.dart';

class PostsPage extends StatefulWidget {
  final String country;
  const PostsPage({super.key, required this.country});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent(country: widget.country));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: const Text(
          "Posts page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listener: (context, state) {
          listenWhen:
          (previous, current) => current is PostsActionState;
          buildWhen:
          (previous, current) => current is! PostsActionState;
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsfetchingLoadingState:
              return Container(
                child: const CircularProgressIndicator(),
              );
            case PostFetchingSuccessfulState:
              final successstate = state as PostFetchingSuccessfulState;
              // successtate will now contain the posts that are emit to it

              return Container(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: successstate.posts.length,
                  itemBuilder: (context, index) {
                    final post = successstate.posts[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Country name and GDP as header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  post.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'GDP: \$${post.gdp.toStringAsFixed(2)} M',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),

                            // Capital city and region information
                            Row(
                              children: [
                                const Icon(Icons.location_city,
                                    color: Colors.blueAccent, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Capital: ${post.capital}',
                                  style: const TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                const Spacer(),
                                const Icon(Icons.public,
                                    color: Colors.blueGrey, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  post.region,
                                  style: const TextStyle(
                                      color: Colors.blueGrey, fontSize: 14),
                                ),
                              ],
                            ),
                            const Divider(thickness: 1, height: 20),

                            // Currency information
                            Row(
                              children: [
                                const Icon(Icons.currency_exchange,
                                    color: Colors.teal, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  'Currency: ${post.currency.name} (${post.currency.code})',
                                  style: const TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),

                            // Additional country details with icons
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.group,
                                        color: Colors.green, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Population: ${post.population} million',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.apartment,
                                        color: Colors.deepOrange, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Urban Population: ${post.urbanPopulation}%',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.male,
                                        color: Colors.blue, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Life Expectancy (Male): ${post.lifeExpectancyMale} years',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.female,
                                        color: Colors.pinkAccent, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Life Expectancy (Female): ${post.lifeExpectancyFemale} years',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.wifi,
                                        color: Colors.lightBlue, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Internet Users: ${post.internetUsers}%',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.work_outline,
                                        color: Colors.purple, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Employment in Services: ${post.employmentServices}%',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.landscape,
                                        color: Colors.brown, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Forested Area: ${post.forestedArea}%',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.local_airport,
                                        color: Colors.redAccent, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Tourists: ${post.tourists}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
