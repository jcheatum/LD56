class_name MagnifyingGlass extends TowerBase

@export var ray_length: float = 200

@onready var raycast2d: RayCast2D = $RayCast2D
@onready var line2d: Line2D = $RayCast2D/Line2D

var sun_angle: float = 45

func _process(delta: float) -> void:
	super._process(delta)
	update_light_direction()

func ACTIVE_UPDATE(delta):
	if raycast2d.is_colliding():
		var collider = raycast2d.get_collider()
		if collider != null and collider.has_method("damage"):
			collider.damage(damage * delta)
			line2d.points[1] = raycast2d.get_collision_point()-raycast2d.global_position
	else:
		line2d.points[1] = raycast2d.target_position

func update_light_direction():
	aim_direction = Vector2.from_angle(deg_to_rad(sun_angle)).normalized()
	raycast2d.target_position = aim_direction*ray_length
