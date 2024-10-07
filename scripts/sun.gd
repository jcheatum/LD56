extends TextureRect

enum SunDirection {
	RIGHT,
	DOWN,
	LEFT,
}

var atlas_positions = {
	SunDirection.RIGHT: Vector2(64, 32),
	SunDirection.DOWN: Vector2(0, 32),
	SunDirection.LEFT: Vector2(32, 0),
}


func set_sun_direction(dir: SunDirection):
	$Direction.texture.region.position = atlas_positions[dir]
