import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/bloc/audio_cubit.dart';

import '../bloc/audio_state.dart';

class MainScreen extends StatelessWidget {
  final AudioPlayer player = AudioPlayer();
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Application'),
        centerTitle: true,
      ),
      body: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          if (state is AudioStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AudioStateLoaded) {
            return ListView.builder(
              itemCount: state.lstData.length,
              padding: const EdgeInsets.only(left: 8, right: 8),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Theme.of(context).primaryColor,
                  highlightColor: Colors.amber,
                  onTap: () {
                    playAudio(state.lstData[index].data);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.music_note),
                          Expanded(
                            child: Text(
                              state.lstData[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const Icon(
                            Icons.play_arrow,
                            size: 32,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is AudioStateFailure) {
            return Center(
              child: Text(
                state.error,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  void playAudio(String path) async {
    player.setAudioSource(AudioSource.file(path));
    await player.play();
  }
}
