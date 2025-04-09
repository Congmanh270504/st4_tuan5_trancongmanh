import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/Buoi7/Bai1/playlist_screen.dart';
import 'package:st4_tuan5_trancongmanh/model/song.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _audioPlayer;
  int _currentSongIndex = 0;
  late AnimationController _controller;
  double _progress = 0.65; // Example progress value
  bool _isPlaying = false;
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
    // Lắng nghe khi bài hát kết thúc
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong(); // Tự động chuyển bài khi hết
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playSong() async {
    print('Playing song: ${songs[_currentSongIndex].audioUrl}');
    // await _audioPlayer.play(AssetSource('audios/1.mp3'));
    await _audioPlayer.play(AssetSource(songs[_currentSongIndex].audioUrl));
    setState(() {
      _isPlaying = true;
    });
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _stopSong() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _nextSong() {
    setState(() {
      if (_currentSongIndex < songs.length - 1) {
        _currentSongIndex++;
      } else {
        _currentSongIndex = 0; // Quay lại bài đầu nếu hết danh sách
      }
      _stopSong(); // Dừng bài hiện tại trước khi phát bài mới
      _playSong();
    });
  }

  void _previousSong() {
    setState(() {
      if (_currentSongIndex > 0) {
        _currentSongIndex--;
      } else {
        _currentSongIndex =
            songs.length - 1; // Chuyển đến bài cuối nếu đang ở đầu
      }
      _stopSong(); // Dừng bài hiện tại trước khi phát bài mới
      _playSong();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'ALBUM',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 40),
        // Circular progress indicator with album art
        Expanded(
          child: Center(
            child: SizedBox(
              width: 250,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer progress circle
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 4,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  // Album art container
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Play button
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        _togglePlay();
                        if (_isPlaying == false) {
                          _pauseSong();
                        } else {
                          _playSong();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Song title and artist
        Text(
          songs[_currentSongIndex].title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          songs[_currentSongIndex].artist,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        const SizedBox(height: 40),
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white70),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Player controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous, size: 32),
              onPressed: () {
                _previousSong();
              },
            ),
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 32,
                color: _isFavorite ? Theme.of(context).primaryColor : null,
              ),
              onPressed: _toggleFavorite,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next, size: 32),
              onPressed: () {
                _nextSong();
              },
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
              onPressed: () {
                _togglePlay();
                if (_isPlaying == false) {
                  _pauseSong();
                } else {
                  _playSong();
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Progress bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.white24,
              thumbColor: Theme.of(context).primaryColor,
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: _progress,
              onChanged: (value) {
                setState(() {
                  _progress = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Down arrow to indicate swipe to playlist
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () {
            // Navigate to playlist screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PlaylistScreen()),
            );
            Scrollable.ensureVisible(
              context,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
