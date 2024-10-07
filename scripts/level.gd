extends Node2D

enum LevelState{BUY,DEFEND,WIN,FAIL}

signal change_scene(scene_name)
signal return_to_main_menu
signal lose

@export var initial_state: LevelState = LevelState.BUY
@export var is_last_level: bool
@export var next_level: String

@onready var current_state: LevelState = initial_state

var sun_angle: float = 0
var current_wave: int = 0

func _ready():
	$WaveSpawner.wave_done.connect(wave_done)
	$PicnicBasket.dead.connect(_on_picnic_basket_dead)
	match current_state:
		LevelState.BUY:
			BUY_ENTER()
		LevelState.DEFEND:
			DEFEND_ENTER()
		LevelState.WIN:
			WIN_ENTER()
		LevelState.FAIL:
			FAIL_ENTER()
	
func _process(delta):
	match current_state:
		LevelState.BUY:
			BUY_UPDATE(delta)
		LevelState.DEFEND:
			DEFEND_UPDATE(delta)
		LevelState.WIN:
			WIN_UPDATE(delta)
		LevelState.FAIL:
			FAIL_UPDATE(delta)

func wave_done():
	if current_wave+1 >= $WaveSpawner.waves.size():
		change_state(LevelState.WIN)
	else:
		change_state(LevelState.BUY)

func change_state(new_state: LevelState):
	print("Level State Change: " + LevelState.keys()[current_state] + "->" + LevelState.keys()[new_state])
	# Exit previous state
	match current_state:
		LevelState.BUY:
			BUY_EXIT()
		LevelState.DEFEND:
			DEFEND_EXIT()
		LevelState.WIN:
			WIN_EXIT()
		LevelState.FAIL:
			FAIL_EXIT()
	# Change state
	current_state = new_state
	# Enter new state
	match current_state:
		LevelState.BUY:
			BUY_ENTER()
		LevelState.DEFEND:
			DEFEND_ENTER()
		LevelState.WIN:
			WIN_ENTER()
		LevelState.FAIL:
			FAIL_ENTER()

func BUY_ENTER():
	$Market.enable_market = true
	if current_wave < $WaveSpawner.waves.size():
		sun_angle = $WaveSpawner.waves[current_wave].sun_angle

func BUY_UPDATE(delta):
	pass

func BUY_EXIT():
	#$Market.enable_market = false
	pass

func DEFEND_ENTER():
	$WaveSpawner.start_wave(current_wave)

func DEFEND_UPDATE(delta):
	pass

func DEFEND_EXIT():
	if current_wave < $WaveSpawner.waves.size():
		$Market.money += $WaveSpawner.waves[current_wave].reward_money
	current_wave += 1
	
	
func WIN_ENTER():
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/wave_win.wav"))
	change_state(LevelState.BUY)

func WIN_UPDATE(delta):
	pass

func WIN_EXIT():
	if is_last_level:
		return_to_main_menu.emit()
	else:
		change_scene.emit(next_level)

func FAIL_ENTER():
	pass

func FAIL_UPDATE(delta):
	pass

func FAIL_EXIT():
	pass

func _on_start_wave_pressed() -> void:
	if current_state == LevelState.BUY:
		change_state(LevelState.DEFEND)


func _on_picnic_basket_dead() -> void:
	lose.emit()
