extends CharacterBody3D


const MOVE_SPEED := 3
const ACCELERATION := 0.5

var screen_limit := 0.2
var rotation_factor := 10.0


func _physics_process(delta: float) -> void:
	var input_dir := Vector3.ZERO
	
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_down", "ui_up")
	input_dir.normalized()
	
	velocity.x = lerp(velocity.x, input_dir.x * MOVE_SPEED, ACCELERATION * delta)
	velocity.y = lerp(velocity.y, input_dir.y * MOVE_SPEED, ACCELERATION * delta)
	
	transform.origin.x = clamp(transform.origin.x , -screen_limit, screen_limit)
	transform.origin.y = clamp(transform.origin.y , -screen_limit, screen_limit)
	
	rotation_degrees.x = velocity.y / rotation_factor
	rotation_degrees.y = -velocity.x / rotation_factor
	rotation_degrees.z = velocity.x / -rotation_factor
	
	
	move_and_slide()
