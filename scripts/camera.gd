extends Camera3D

@export var forward_speed: float = 0.2
@onready var game_manager = get_node("/root/Main")

func _ready():
	game_manager = get_node("/root/Main") # adjust path

func _process(delta: float) -> void:
	if not game_manager.game_started:
		return  # stop moving until SPACE

	var diff = get_node("/root/Main/DifficultyController").difficulty
	global_position += -global_transform.basis.z * (forward_speed * diff) * delta
