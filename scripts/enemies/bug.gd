class_name Bug extends Area2D

@export var navigator: NavigationAgent2D
@export var speed: float = 70.0
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction = navigator.get_next_path_position() - global_position
	velocity = Global.exp_decay(velocity, direction.normalized() * speed, 16, delta)
	navigator.set_velocity(velocity)
	self.position += velocity * delta

func set_target(location: Vector2) -> void:
	navigator.target_position = location
