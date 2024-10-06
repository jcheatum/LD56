class_name TowerBase extends Area2D

enum TowerState{PLACING,ROTATING,ACTIVE}

const LeftBounds: float = 10
const RightBounds: float = 1740
const LowerBounds: float = 1200 #1070
const UpperBounds: float = 10

signal sell_tower
signal place_tower
signal pickup_tower

@export var rotatable: bool
@export var movable: bool
@export var placable_on_path: bool
@export var initial_state: TowerState = TowerState.PLACING
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
	pickup_tower.emit()
	
func PLACING_UPDATE(_delta):
	global_position = (get_global_mouse_position()/128 as Vector2i)*128 + Vector2i(64,64)
	if Input.is_action_just_released("left_click") and in_bounds(global_position) and !has_overlapping_areas() and (!has_overlapping_bodies() or placable_on_path):
		if rotatable:
			change_state(TowerState.ROTATING)
		else:
			change_state(TowerState.ACTIVE)
	
func PLACING_EXIT():
	place_tower.emit()
	
func ROTATING_ENTER():
	$Line2D.visible = true
	
func ROTATING_UPDATE(_delta):
	# Lock orientation
	aim_direction = get_global_mouse_position() - global_position
	if abs(aim_direction.x) > abs(aim_direction.y):
		aim_direction.x = signf(aim_direction.x)
		aim_direction.y = 0
	else:
		aim_direction.x = 0
		aim_direction.y = signf(aim_direction.y)
	if Input.is_action_just_pressed("left_click"):
			change_state(TowerState.ACTIVE)
	$Line2D.points[1] = aim_direction*200
	
func ROTATING_EXIT():
	print("Aim Direction: " + str(aim_direction))
	$Line2D.visible = false

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
			pass
			#change_state(TowerState.ROTATING)
	elif Input.is_action_just_pressed("right_click") and current_state==TowerState.ACTIVE:
		sell_tower.emit()
		self.queue_free()

func in_bounds(pos: Vector2) -> bool:
	if pos.x > RightBounds:
		return false
	elif pos.x < LeftBounds:
		return false
	elif pos.y > LowerBounds:
		return false
	elif pos.y < UpperBounds:
		return false
	else:
		return true
	
