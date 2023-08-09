import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/audio_state.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioCubit extends Cubit<AudioState> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  bool hasPermission = false;

  AudioCubit() : super(AudioStateLoading()) {
    fetchAllAudio();
  }

  void fetchAllAudio() async {
    emit(AudioStateLoading());
    hasPermission = await _onAudioQuery.checkAndRequest(retryRequest: true);

    if (hasPermission) {
      List<SongModel> lstData = await _onAudioQuery.querySongs(
        sortType: SongSortType.DATE_ADDED,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );

      if (lstData.isNotEmpty) {
        emit(AudioStateLoaded(lstData));
      } else {
        emit(AudioStateFailure('No Audio Found.'));
      }
    } else {
      emit(AudioStateFailure('Permission Denied'));
    }
  }
}
