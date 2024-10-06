class_name Flamethrower extends TowerBase

@export var on_timer: float
@export var off_timer: float

@onready var Flame: Node2D = $Flame
@onready var FlameZone: Area2D = $Flame/FlameZone

func _ready() -> void:
	$Flame/FlameZone/AnimatedSprite2D.play()

var timer: float = off_timer
var is_flame_on: bool = false

func _process(delta: float) -> void:
	super._process(delta)
	self.look_at(global_position+aim_direction)

func ACTIVE_ENTER():
	timer = off_timer
	flame_off()

func ACTIVE_UPDATE(delta):
	timer -= delta
	if timer <= 0:
		match is_flame_on:
			true:
				flame_off()
				is_flame_on = false
			false:
				flame_on()
				is_flame_on = true
	if is_flame_on and FlameZone.has_overlapping_areas():
		for collider in FlameZone.get_overlapping_areas():
			if collider != null and collider.has_method("damage"):
				collider.damage(damage*delta)

func flame_on():
	print("FLAME ON!")
	Flame.visible = true
	timer = on_timer

func flame_off():
	print("Flame off...")
	Flame.visible = false
	timer = off_timer
