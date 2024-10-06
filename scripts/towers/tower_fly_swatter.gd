class_name FlySwatter extends TowerBase

@export var swat_rate: float

@onready var Swatter: Node2D = $Swatter
@onready var SwatZone: Area2D = $Swatter/SwatZone
@onready var Smoke: Sprite2D = $Swatter/SwatZone/Sprite2D

var swat_timer: float = swat_rate
var smoke_timer: float = 0.3

func _process(delta: float) -> void:
	super._process(delta)
	Swatter.look_at(global_position+aim_direction)

func ACTIVE_ENTER():
	swat_timer = swat_rate

func ACTIVE_UPDATE(delta):
	swat_timer -= delta
	if swat_timer <= 0:
		swat()
		swat_timer = swat_rate
	smoke_timer -= delta
	if smoke_timer <= 0:
		Smoke.visible = false
		
func swat():
	#print("Swat!")
	Smoke.visible = true
	smoke_timer = 0.3
	$AnimatedSprite2D.play()
	if SwatZone.has_overlapping_areas():
		for collider in SwatZone.get_overlapping_areas():
			if collider != null and collider.has_method("damage"):
				collider.damage(damage)


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.frame = 0
