extends Node2D


func _on_main_menu_game_start():
	$MainMenu.hide()
	$Game.show()
	$Game.process_mode = Node.PROCESS_MODE_INHERIT


func _on_main_menu_open_settings():
	$MainMenu.hide()
	$SettingsMenu.show()


func _on_settings_menu_done():
	$SettingsMenu.hide()
	$MainMenu.show()


func _on_game_finish():
	$Game.process_mode = Node.PROCESS_MODE_DISABLED
	$Game.hide()
	$Credits.show()
	$Credits.process_mode = Node.PROCESS_MODE_INHERIT
