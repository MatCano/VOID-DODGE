extends Camera3D

@export var speed: float = 0.1   # units per second

func _process(delta: float) -> void:
	# Move forward along the camera's local -Z axis
	global_position += -global_transform.basis.z * speed * delta
