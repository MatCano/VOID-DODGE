extends Node

@export var difficulty := 1.0				# starts at normal speed
@export var difficulty_increase := 0.25		# how fast it ramps up
@export var max_difficulty := 25.0			# prevents insane speeds
@onready var game_manager = get_node("/root/Main") ####################

####################
func _ready():
	game_manager = get_node("/root/Main") # adjust path
####################

func _process(delta: float) -> void:
	if not game_manager.game_started:
		return  # stop moving until SPACE

	difficulty = min(difficulty + difficulty_increase * delta, max_difficulty)
