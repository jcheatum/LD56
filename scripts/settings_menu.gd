extends Control

signal done
signal music_vol_set(volume: float)
signal sfx_vol_set(volume: float)

var music_value
var sfx_value

# Called when the node enters the scene tree for the first time.
func _ready():
	music_value = $ColumnsContainer/MusicVolContainer/MusicVolSlider.value
	sfx_value = $ColumnsContainer/SfxVolContainer/SfxVolSlider.value
	

func _on_mute_check_box_toggled(toggled_on):
	if toggled_on:
		music_value = $ColumnsContainer/MusicVolContainer/MusicVolSlider.value
		sfx_value = $ColumnsContainer/SfxVolContainer/SfxVolSlider.value
		$ColumnsContainer/MusicVolContainer/MusicVolSlider.value = $ColumnsContainer/MusicVolContainer/MusicVolSlider.min_value
		$ColumnsContainer/SfxVolContainer/SfxVolSlider.value = $ColumnsContainer/SfxVolContainer/SfxVolSlider.min_value
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


func _on_music_vol_slider_value_changed(value):
	emit_signal("music_vol_set", value)


func _on_sfx_vol_slider_value_changed(value):
	emit_signal("sfx_vol_set", value)


func _on_main_menu_open_settings():
	$DoneButton.grab_focus()


func _on_music_vol_slider_drag_ended(value_changed):
	if value_changed:
		music_value = $ColumnsContainer/MusicVolContainer/MusicVolSlider.value


func _on_sfx_vol_slider_drag_ended(value_changed):
	if value_changed:
		sfx_value = $ColumnsContainer/SfxVolContainer/SfxVolSlider.value
