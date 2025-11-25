extends Node3D

@export var asteroid_scene: PackedScene
@export var spawn_rate: float = 1.2
@export var spawn_range_x: float = 0.2
@export var spawn_offset_z: float = 0.0
@export var z_speed: float = 0.2

var timer := 0.0
var z_offset_accumulator := 0.0
@onready var game_manager = get_node("/root/Main")

func _ready():
	game_manager = get_node("/root/Main") # adjust path

func _process(delta: float) -> void:
	if not game_manager.game_started:
		return  # stop spawning until SPACE

	var diff = get_node("/root/Main/DifficultyController").difficulty
	z_offset_accumulator += (z_speed * diff) * delta
	timer += delta * (1 + log(diff) / log(10))

	if timer >= spawn_rate:
		timer = 0.0
		spawn_asteroid()

func spawn_asteroid():
	if asteroid_scene == null:
		push_error("Asteroid scene not assigned!")
		return

	var asteroid := asteroid_scene.instantiate()
	var random_x = randf_range(-spawn_range_x, spawn_range_x)
	var spawn_z = spawn_offset_z - z_offset_accumulator

	var spawn_pos = Vector3(
		global_position.x + random_x,
		global_position.y,
		global_position.z + spawn_z
	)

	asteroid.global_position = spawn_pos
	get_tree().current_scene.add_child(asteroid)
