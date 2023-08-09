import 'package:on_audio_query/on_audio_query.dart';

abstract class AudioState {}

class AudioStateLoading extends AudioState {}

class AudioStateLoaded extends AudioState {
  final List<SongModel> lstData;
  AudioStateLoaded(this.lstData);
}

class AudioStateFailure extends AudioState {
  final String error;
  AudioStateFailure(this.error);
}
