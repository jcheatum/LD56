class_name TowerBase extends Area2D

enum TowerState{PLACING,ROTATING,ACTIVE}

@export var rotatable: bool
@export var movable: bool
@export var initial_state: TowerState = TowerState.ACTIVE
@export var damage: float = 0

@onready var current_state: TowerState = initial_state

var aim_direction: Vector2 = Vector2.RIGHT

func _ready():
	match current_state:
		TowerState.PLACING:
			PLACING_ENTER()
		TowerState.ROTATING:
			ROTATING_ENTER()
		TowerState.ACTIVE:
			ACTIVE_ENTER()
	
func _process(delta):
	match current_state:
		TowerState.PLACING:
			PLACING_UPDATE(delta)
		TowerState.ROTATING:
			ROTATING_UPDATE(delta)
		TowerState.ACTIVE:
			ACTIVE_UPDATE(delta)

func change_state(new_state: TowerState):
	print("Tower State Change: " + TowerState.keys()[current_state] + "->" + TowerState.keys()[new_state])
	# Exit previous state
	match current_state:
		TowerState.PLACING:
			PLACING_EXIT()
		TowerState.ROTATING:
			ROTATING_EXIT()
		TowerState.ACTIVE:
			ACTIVE_EXIT()
	# Change state
	current_state = new_state
	# Enter new state
	match current_state:
		TowerState.PLACING:
			PLACING_ENTER()
		TowerState.ROTATING:
			ROTATING_ENTER()
		TowerState.ACTIVE:
			ACTIVE_ENTER()
	
func PLACING_ENTER():
	pass
	
func PLACING_UPDATE(_delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_released("left_click"):
		if rotatable:
			change_state(TowerState.ROTATING)
		else:
			change_state(TowerState.ACTIVE)
	
func PLACING_EXIT():
	pass
	
func ROTATING_ENTER():
	pass
	
func ROTATING_UPDATE(_delta):
	aim_direction = (get_global_mouse_position() - global_position).normalized()
	if Input.is_action_just_pressed("left_click"):
			change_state(TowerState.ACTIVE)
	
func ROTATING_EXIT():
	print("Aim Direction: " + str(aim_direction))

func ACTIVE_ENTER():
	pass
	
func ACTIVE_UPDATE(_delta):
	pass
	
func ACTIVE_EXIT():
	pass

func _input_event(_viewport: Viewport, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("left_click") and current_state==TowerState.ACTIVE:
		if movable:
			change_state(TowerState.PLACING)
		elif rotatable:
			change_state(TowerState.ROTATING)
