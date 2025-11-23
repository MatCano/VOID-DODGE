extends CharacterBody3D

const MOVE_SPEED := 0.5          # horizontal movement target speed
const ACCELERATION := 10.0       # how fast the ship reaches target speed
const FORWARD_SPEED := 0.1       # constant forward movement

const TILT_AMOUNT := 15.0        # max tilt angle in degrees
const TILT_SMOOTH := 8.0         # how fast tilt returns to center

var screen_limit := 0.2

func _physics_process(delta: float) -> void:
	# -------------------------------------------------
	# 1. LEFT/RIGHT INPUT ONLY
	# -------------------------------------------------
	var input_x: float = Input.get_axis("ui_left", "ui_right")

	# -------------------------------------------------
	# 2. Accelerated horizontal movement
	# -------------------------------------------------
	var target_x_speed: float = input_x * MOVE_SPEED
	velocity.x = lerp(velocity.x, target_x_speed, ACCELERATION * delta)

	# -------------------------------------------------
	# 3. No vertical movement
	# -------------------------------------------------
	velocity.y = 0.0

	# -------------------------------------------------
	# 4. Constant forward movement
	# -------------------------------------------------
	velocity.z = -FORWARD_SPEED

	# -------------------------------------------------
	# 5. Keep ship inside camera view
	# -------------------------------------------------
	transform.origin.x = clamp(transform.origin.x, -screen_limit, screen_limit)
	transform.origin.y = clamp(transform.origin.y, -screen_limit, screen_limit)

	# -------------------------------------------------
	# 6. Smooth tilt based on horizontal movement
	# -------------------------------------------------
	var target_tilt: float = (velocity.x / MOVE_SPEED) * TILT_AMOUNT
	var smooth_tilt: float = lerp(rotation_degrees.z, -target_tilt, TILT_SMOOTH * delta)

	rotation_degrees.x = 0.0
	rotation_degrees.y = lerp(rotation_degrees.y, target_tilt * 0.3, TILT_SMOOTH * delta)
	rotation_degrees.z = smooth_tilt

	# -------------------------------------------------
	# 7. Move the ship
	# -------------------------------------------------
	move_and_slide()
