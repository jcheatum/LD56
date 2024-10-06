extends Node

#just for testing purposes

@onready var spawner: Node2D = $"../WaveSpawner"

var wave_num: int = 0

func _ready() -> void:
	spawner.wave_done.connect(_on_wave_done)
	await spawner.ready
	spawner.start_wave(wave_num)

func _process(delta: float) -> void:
	pass

func _on_wave_done():
	wave_num += 1
	spawner.start_wave(wave_num)
