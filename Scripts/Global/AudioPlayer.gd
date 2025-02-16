extends AudioStreamPlayer

const menu_music = preload("res://assets/Musics/menusong.wav")
const level_music = preload("res://assets/Musics/levelsong.wav")
# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream):
	if stream == music:
		return
	stream = music
	if(!playing):
		play()
	
func play_music_level():
	_play_music(level_music)
		
func play_music_menu():
	_play_music(menu_music)
	
	
