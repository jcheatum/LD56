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
