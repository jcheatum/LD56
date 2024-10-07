extends Node

var audio_stream_players: Array[AudioStreamPlayer]
var volume: float

func _ready():
	if ($"../Main/SettingsMenu" != null):
		$"../Main/SettingsMenu".sfx_vol_set.connect(set_volume)

func set_volume(new_vol: float):
	volume = new_vol
	print("SFX Volume: " + str(volume))

func PlaySoundEffect(stream :AudioStream, volume_scale: float = 1, pitch_scale: float = 1):
	var available_player: AudioStreamPlayer = null
	# Look for a player that is not currently playing
	for stream_player in audio_stream_players:
		if stream_player.playing == false:
			available_player = stream_player
	# Make a new player if needed
	if available_player == null:
		var new_player: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(new_player)
		available_player = new_player
		audio_stream_players.append(available_player)
	# Play the sound
	available_player.stream = stream
	available_player.volume_db = volume * volume_scale
	available_player.pitch_scale = pitch_scale
	available_player.play()
