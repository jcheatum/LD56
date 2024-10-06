class_name WaveSpawner extends Node2D

class Wave:
	var spawn_rate: float
	var reward_money: float
	var sun_angle: float
	var enemies: Dictionary

signal wave_done

@export var wave_file_path: String
@export var enemy_data_path: String
@export var spawn_range: float = 40

@onready var spawn_points: Array[Node] = get_children()

var waves: Array[Wave]
var enemy_data: Dictionary
var bug_queue: Array[String]
var spawn_rate: float
var spawn_timer: float
var enemy_count: int = 0;

func _ready():
	load_enemy_data()
	load_wave_data()
	
func _process(delta):
	if bug_queue.size() > 0:
		spawn_timer -= delta
		if spawn_timer <= 0:
			spawn_bug()
			spawn_timer = spawn_rate
	
func start_wave(wave: int):
	assert(wave < waves.size(), "Wave number does not exist!")
	print("Starting Wave: " + str(wave))
	spawn_rate = waves[wave].spawn_rate
	enemy_count = 0
	for bug in waves[wave].enemies:
		for i in waves[wave].enemies[bug]:
			bug_queue.append(bug)
	shuffle_bug_queue()
	
func spawn_bug():
	enemy_count += 1
	print("Spawning... " + bug_queue[0])
	
	# Load and Instantiate
	var scene = load(enemy_data[bug_queue[0]])
	bug_queue.pop_front()
	var instance = scene.instantiate() as Bug
	instance.bug_died.connect(_on_bug_death)
	add_sibling(instance)
	instance.set_target($"../PicnicBasket".position)
	
	# Position
	assert(spawn_points.size() > 0, "No Spawn Points are set!")
	var spawnPoint: Node2D = spawn_points[randi() % spawn_points.size()]
	instance.global_position = spawnPoint.global_position
	instance.global_position.x += randf_range(-spawn_range, spawn_range)
	instance.global_position.y += randf_range(-spawn_range, spawn_range)
	
func _on_bug_death():
	enemy_count -= 1
	if enemy_count <= 0 and bug_queue.size() <= 0:
		wave_done.emit()
		
func shuffle_bug_queue():
	var rand1: int
	var rand2: int
	var temp: String
	for i in bug_queue.size():
		rand1 = randf_range(0,bug_queue.size())
		rand2 = randf_range(0,bug_queue.size())
		temp = bug_queue[rand1]
		bug_queue[rand1] = bug_queue[rand2]
		bug_queue[rand2] = temp
	print("Shuffled Queue: " + str(bug_queue))
		
func load_enemy_data():
	var config = ConfigFile.new()
	var err = config.load(enemy_data_path)
	assert(err == OK, "Error loading enemy data file.")
	for enemy in config.get_sections():
		enemy_data[enemy] = config.get_value(enemy, "path")
	print("Finished loading enemy data file!")

func load_wave_data():
	var config = ConfigFile.new()
	var err = config.load(wave_file_path)
	assert(err == OK, "Error loading wave configuration file.")
	for wave in config.get_sections():
		var new_wave: Wave = Wave.new()
		new_wave.spawn_rate = config.get_value(wave, "spawn_rate")
		new_wave.reward_money = config.get_value(wave, "reward_money")
		new_wave.sun_angle = config.get_value(wave, "sun_angle")
		for key in config.get_section_keys(wave):
			if !["spawn_rate","reward_money","sun_angle"].has(key):
				new_wave.enemies[key] = config.get_value(wave, key)
		waves.append(new_wave)
	print("Finished loading wave configuration file!")
