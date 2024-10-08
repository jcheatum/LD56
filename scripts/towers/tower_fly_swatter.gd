class_name FlySwatter extends TowerBase

@export var swat_rate: float = 2
@export var slow_time: float = 1

@onready var Swatter: Node2D = $Swatter
@onready var SwatZone: Area2D = $Swatter/SwatZone
@onready var Smoke: Sprite2D = $Swatter/SwatZone/Sprite2D

var swat_timer: float = swat_rate
var smoke_timer: float = 0.3

func _process(delta: float) -> void:
	super._process(delta)
	Swatter.look_at(global_position+aim_direction)

func ACTIVE_ENTER():
	super.ACTIVE_ENTER()
	swat_timer = swat_rate

func ACTIVE_UPDATE(delta):
	swat_timer -= delta
	if swat_timer <= 0:
		swat()
		swat_timer = swat_rate
	smoke_timer -= delta
	if smoke_timer <= 0:
		Smoke.visible = false
		
func ROTATING_UPDATE(_delta):
	# Lock orientation
	aim_direction = get_global_mouse_position() - global_position
	
	if abs(aim_direction.x) > abs(aim_direction.y):
		aim_direction.x = signf(aim_direction.x)
		aim_direction.y = 0
		if aim_direction.x > 0:
			$AnimatedSprite2D.animation = "right"
			$AnimatedSprite2D.offset.x = 0
			$AnimatedSprite2D.offset.y = 0
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.animation = "left"
			$AnimatedSprite2D.offset.x = -32
			$AnimatedSprite2D.offset.y = 0
			$AnimatedSprite2D.flip_h = true

	else:
		aim_direction.x = 0
		aim_direction.y = signf(aim_direction.y)
		if aim_direction.y > 0:
			$AnimatedSprite2D.animation = "down"
			$AnimatedSprite2D.offset.x = 0
			$AnimatedSprite2D.offset.y = 0
		else:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.offset.x = 0
			$AnimatedSprite2D.offset.y = 0
	$AnimatedSprite2D.frame = 0
	
	#if aim_direction.x > 0:
	#	aim_direction.x = 1
	#	$AnimatedSprite2D.flip_h = false
	#	$AnimatedSprite2D.offset.x = 0
	#else:
	#	aim_direction.x = -1
	#	$AnimatedSprite2D.flip_h = true
	#	$AnimatedSprite2D.offset.x = -32
	#aim_direction.y = 0
	if Input.is_action_just_pressed("left_click"):
			change_state(TowerState.ACTIVE)
	$Line2D.points[1] = aim_direction*200

func swat():
	#print("Swat!")
	
	#Smoke.visible = true
	smoke_timer = 0.3
	$AnimatedSprite2D.play()
	


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.frame = 0
	if SwatZone.has_overlapping_areas():
		for collider in SwatZone.get_overlapping_areas():
			SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/swat.wav"))
			if collider != null and collider.has_method("damage"):
				collider.damage(damage)
			if collider != null and collider.has_method("slow"):
				collider.slow(slow_time)	
			
