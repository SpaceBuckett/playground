import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learning_ground/UI/firebase_flowers_streams/firebase_stream_viewmodel.dart';
import 'package:provider/provider.dart';

class FlowersStreamScreen extends StatelessWidget {
  const FlowersStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlowersScreenViewModel(),
      child: Consumer<FlowersScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Stream & Stream Builder'),
          ),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Stack(
              children: [
                StreamBuilder(
                    stream: model.firebaseDb.getflowersFromDatabase(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Flowers Found :/',
                          ),
                        );
                      }

                      return Wrap(
                        children: [
                          ...snapshot.data!.map(
                            (flower) => Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(flower.name ?? 'No Name'),
                                    IconButton(
                                      onPressed: () {
                                        // if (flower.flowerId != null) {
                                        model.likeDislikeFlower(
                                          flowerId: flower.flowerId!,
                                          isLiked: flower.isFavorite ?? false
                                              ? false
                                              : true,
                                        );
                                        // }
                                      },
                                      icon: Icon(
                                        flower.isFavorite ?? false
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    // height: 120,
                    width: MediaQuery.sizeOf(context).width - 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black38,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 110,
                            child: TextFormField(
                              controller: model.nameController,
                              decoration: const InputDecoration(
                                hintText: 'Flower Name',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                          IconButton.filled(
                            onPressed: () {
                              model.saveFlower();
                            },
                            icon: Transform.rotate(
                              angle: -pi / 6,
                              child: const Icon(
                                Icons.send_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
