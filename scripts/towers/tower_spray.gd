class_name Spray extends Flamethrower

func _process(delta: float) -> void:
	super._process(delta)
	self.look_at(global_position+Vector2.RIGHT)
	$Flame.look_at(global_position+aim_direction)
	$Line2D.look_at(global_position+aim_direction)

func ROTATING_UPDATE(_delta):
	# Lock orientation
	aim_direction = get_global_mouse_position() - global_position
	if abs(aim_direction.x) > abs(aim_direction.y):
		aim_direction.x = signf(aim_direction.x)
		aim_direction.y = 0
		if aim_direction.x > 0:
			$AnimatedSprite2D.animation = "right"
		else:
			$AnimatedSprite2D.animation = "left"
	else:
		aim_direction.x = 0
		aim_direction.y = signf(aim_direction.y)
		if aim_direction.y > 0:
			$AnimatedSprite2D.animation = "down"
		else:
			$AnimatedSprite2D.animation = "up"
	$AnimatedSprite2D.frame = 0
	if Input.is_action_just_pressed("left_click"):
			change_state(TowerState.ACTIVE)
	$Line2D.points[1] = Vector2.RIGHT*200

func flame_on():
	$AnimatedSprite2D.frame = 1
	SfxPlayer.PlaySoundEffect(preload("res://assets/sfx/spray.wav"))
	print("FLAME ON!")
	Flame.visible = true
	timer = on_timer
	
func flame_off():
	super.flame_off()
	$AnimatedSprite2D.frame = 0

func _on_area_exited(area: Area2D) -> void:
	if area is Bug:
		$AnimatedSprite2D.frame = 0
