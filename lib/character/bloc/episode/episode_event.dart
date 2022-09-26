import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/character/models/episode.dart';

abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();
  @override
  List<Object> get props => [];
}

class EpisodeFetchEvent extends EpisodeEvent {
  final List<String> urls;
  const EpisodeFetchEvent({required this.urls});

  @override
  List<Object> get props => [urls];
}

class EpisodeResetEvet extends EpisodeEvent {
  const EpisodeResetEvet();

  @override
  List<Object> get props => [];
}
