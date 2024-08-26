extends Node2D


func _on_main_menu_game_start():
	$MainMenu.hide()
	$Game.show()


func _on_main_menu_open_settings():
	$MainMenu.hide()
	$SettingsMenu.show()


func _on_settings_menu_done():
	$SettingsMenu.hide()
	$MainMenu.show()


func _on_game_finished():
	$Game.hide()
	$Credits.show()


func _on_settings_menu_music_vol_set(volume):
	$MusicPlayer.volume_db = volume


func _on_settings_menu_sfx_vol_set(volume):
	$SfxPlayer2D.volume_db = volume


func _on_game_paused():
	get_tree().paused = true
	$PauseMenu.show()


func _on_pause_menu_resume():
	get_tree().paused = false
	$PauseMenu.hide()


func _on_pause_menu_return_to_menu():
	get_tree().paused = false
	$PauseMenu.hide()
	$Game.hide()
	$MainMenu.show()
