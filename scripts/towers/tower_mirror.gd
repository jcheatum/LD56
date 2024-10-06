class_name Mirror extends TowerBase

@export var ray_length: float = 200
@export var max_bounces: int = 10

@onready var raycast2d: RayCast2D = $RayCast2D
@onready var line2d: Line2D = $RayCast2D/Line2D

var reflecting: bool = false
var initial_damage: float

func _ready():
	super._ready()
	initial_damage = damage

func _process(delta: float) -> void:
	super._process(delta)
	$Reflector.look_at(global_position+aim_direction)
	
	if reflecting:
		raycast2d.visible = true
	else:
		raycast2d.visible = false
	reflecting = false

func ROTATING_UPDATE(_delta):
	# Lock orientation
	aim_direction = get_global_mouse_position() - global_position
	var angle = aim_direction.angle()
	angle = (PI/4) * round(angle/(PI/4))
	aim_direction = Vector2.RIGHT.rotated(angle)
	if Input.is_action_just_pressed("left_click"):
			change_state(TowerState.ACTIVE)
	$Line2D.points[1] = aim_direction*200
	
func reflect(point: Vector2, ray: Vector2, delta, bounce: int):
	if bounce > max_bounces or reflecting:
		return
	damage = initial_damage - (initial_damage*(bounce as float / max_bounces as float))
	line2d.default_color.a = (max_bounces - bounce) as float / max_bounces as float
	reflecting = true
	var reflect_direction: Vector2
	reflect_direction = ray.bounce(aim_direction)
	raycast2d.target_position = (point - position) + reflect_direction*ray_length
	raycast2d.global_position = point
	line2d.points[1] = raycast2d.target_position
	
	if raycast2d.is_colliding():
		var collider = raycast2d.get_collider()
		if collider != null and collider.has_method("damage"):
			collider.damage(damage * delta)
			line2d.points[1] = raycast2d.get_collision_point()-raycast2d.global_position
		if collider != null and collider.owner != null and collider.owner.has_method("reflect") and collider.owner != self:
			collider.owner.reflect(raycast2d.get_collision_point(),reflect_direction,delta,bounce+1)
			line2d.points[1] = raycast2d.get_collision_point()-raycast2d.global_position
	else:
		line2d.points[1] = raycast2d.target_position
