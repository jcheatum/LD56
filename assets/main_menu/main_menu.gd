extends Control

signal game_start
signal open_settings

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonsContainer/Start.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	emit_signal("game_start")


func _on_settings_pressed():
	emit_signal("open_settings")


func _on_exit_pressed():
	get_tree().quit()


func _on_settings_menu_done():
	$ButtonsContainer/Settings.grab_focus()
