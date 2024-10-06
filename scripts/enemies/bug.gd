class_name Bug extends Area2D

signal bug_died

@export var speed: float = 70.0
var navigator: NavigationAgent2D
@onready var velocity: Vector2 = Vector2.ZERO
var health_bar: HealthBar
var rotation_container

func _physics_process(delta: float) -> void:
	# Update velocity according to navigation and move
	var direction = navigator.get_next_path_position() - global_position
	velocity = Global.exp_decay(velocity, direction.normalized() * speed, 16, delta)
	navigator.set_velocity(velocity)
	self.position += velocity * delta
	rotation_container.rotation = velocity.angle() + PI/2


# Sets the navigation target for this bug to `location`
func set_target(location: Vector2) -> void:
	navigator.target_position = location


# Pretty self explanitory
func die() -> void:
	bug_died.emit()
	self.queue_free()

# Do `value` points of damage to this bug
func damage(value: float) -> void: 
	health_bar.damage(value)
