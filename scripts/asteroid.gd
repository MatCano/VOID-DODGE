extends StaticBody3D

@export var spin_speed := 2.0
var spin_axis: Vector3

func _ready():
	randomize()

	# Random spin axis
	spin_axis = Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

func _physics_process(delta):
	rotate_object_local(spin_axis, spin_speed * delta)
