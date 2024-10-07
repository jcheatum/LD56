extends Node2D

@onready var settings_return = $MainMenu

func _on_main_menu_game_start():
	$MainMenu.hide()
	$Game.show()
	$Game.start_game()


func _on_main_menu_open_settings():
	$MainMenu.hide()
	settings_return = $MainMenu
	$SettingsMenu.show()


func _on_settings_menu_done():
	$SettingsMenu.hide()
	settings_return.focus_settings()
	settings_return.show()


func _on_game_finished():
	$Game.hide()
	$MainMenu.show()


func _on_settings_menu_music_vol_set(volume):
	$MusicPlayer.volume_db = linear_to_db(volume)


func _on_settings_menu_sfx_vol_set(volume):
	#$SfxPlayer2D.volume_db = volume
	pass


func _on_game_paused():
	get_tree().paused = true
	$PauseMenu.show()
	$PauseMenu/ButtonsContainer/Resume.grab_focus()


func _on_pause_menu_resume():
	get_tree().paused = false
	$PauseMenu.hide()


func _on_pause_menu_return_to_menu():
	get_tree().paused = false
	$PauseMenu.hide()
	$Game.hide()
	$MainMenu.show()


func _on_pause_menu_open_settings():
	$PauseMenu.hide()
	settings_return = $PauseMenu
	$SettingsMenu.show()
