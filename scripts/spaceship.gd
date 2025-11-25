extends CharacterBody3D

const MOVE_SPEED := 0.5
const ACCELERATION := 10.0
const FORWARD_SPEED := 0.2

const TILT_AMOUNT := 15.0
const TILT_SMOOTH := 8.0

var screen_limit := 0.2
@onready var game_manager = get_node("/root/Main")

func _ready():
	game_manager = get_node("/root/Main") # adjust path if needed

func _physics_process(delta: float) -> void:
	if not game_manager.game_started:
		return  # do nothing until SPACE is pressed

	var diff = get_node("/root/Main/DifficultyController").difficulty

	var input_x: float = Input.get_axis("ui_left", "ui_right")
	var target_x_speed: float = input_x * MOVE_SPEED
	velocity.x = lerp(velocity.x, target_x_speed, ACCELERATION * delta)
	velocity.y = 0.0

	velocity.z = -FORWARD_SPEED * diff

	transform.origin.x = clamp(transform.origin.x, -screen_limit, screen_limit)
	transform.origin.y = clamp(transform.origin.y, -screen_limit, screen_limit)

	var target_tilt: float = (velocity.x / MOVE_SPEED) * TILT_AMOUNT
	var smooth_tilt: float = lerp(rotation_degrees.z, -target_tilt, TILT_SMOOTH * delta)

	rotation_degrees.x = 0.0
	rotation_degrees.y = lerp(rotation_degrees.y, target_tilt * 0.3, TILT_SMOOTH * delta)
	rotation_degrees.z = smooth_tilt

	move_and_slide()

	for i in get_slide_collision_count():
		var hit = get_slide_collision(i)
		if hit.get_collider().is_in_group("asteroid"):
			get_tree().call_deferred("reload_current_scene")
