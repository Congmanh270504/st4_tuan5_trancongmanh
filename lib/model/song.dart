class Song {
  final int id;
  final String title;
  final String artist;
  final String duration;
  final String audioUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.audioUrl,
  });
}

List<Song> songs = [
  Song(
    id: 1,
    title: 'Song Title 1',
    artist: 'Artist 1',
    duration: '3:00',
    audioUrl: 'audios/1.mp3',
  ),
  Song(
    id: 2,
    title: 'Song Title 2',
    artist: 'Artist 2',
    duration: '4:00',
    audioUrl: 'audios/2.mp3',
  ),
  Song(
    id: 3,
    title: 'Song Title 3',
    artist: 'Artist 3',
    duration: '5:00',
    audioUrl: 'audios/3.mp3',
  ),
];
