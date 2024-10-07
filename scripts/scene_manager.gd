extends Node2D

signal return_to_menu
signal player_lost
signal scene_changing(scene_name: String)
signal scene_changed(scene_name: String)

var scenes: Dictionary
var active_scene: Node2D = null

func _ready():
	# List Scenes
	scenes["test_level"] = preload("res://assets/game/levels/test_level.tscn")
	scenes["level_1"] = preload("res://assets/game/levels/level_1.tscn")
	scenes["level_2"] = preload("res://assets/game/levels/level_2.tscn")
	scenes["level_3"] = preload("res://assets/game/levels/level_3.tscn")

func change_scene(scene_name: String):
	scene_changed.emit(scene_name)
	assert(scenes.has(scene_name), "Scene " + scene_name + " not found in SceneManager!")
	var instance: Node2D = scenes[scene_name].instantiate()
	add_child(instance)
	if (active_scene != null):
		active_scene.queue_free()
	active_scene = instance
	active_scene.change_scene.connect(_on_active_scene_change_scene)
	active_scene.return_to_main_menu.connect(return_to_main_menu)
	active_scene.lose.connect(_on_active_scene_lose)
	
func _on_active_scene_change_scene(scene_name: String):
	scene_changing.emit(scene_name)


func return_to_main_menu():
	return_to_menu.emit()

func _on_active_scene_lose():
	player_lost.emit()
