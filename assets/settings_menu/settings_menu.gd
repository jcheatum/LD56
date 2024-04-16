extends Control

signal done

var music_value
var sfx_value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mute_check_box_toggled(toggled_on):
	if toggled_on:
		music_value = $ColumnsContainer/MusicVolContainer/MusicVolSlider.value
		sfx_value = $ColumnsContainer/SfxVolContainer/SfxVolSlider.value
		$ColumnsContainer/MusicVolContainer/MusicVolSlider.value = 0
		$ColumnsContainer/SfxVolContainer/SfxVolSlider.value = 0
	else:
		$ColumnsContainer/MusicVolContainer/MusicVolSlider.value = music_value
		$ColumnsContainer/SfxVolContainer/SfxVolSlider.value = sfx_value


func _on_done_button_pressed():
	emit_signal("done")


func _on_fullscreen_check_box_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
