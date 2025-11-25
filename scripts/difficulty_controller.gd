extends Node

@export var difficulty := 1.0				# starts at normal speed
@export var difficulty_increase := 0.25		# how fast it ramps up
@export var max_difficulty := 25.0			# prevents insane speeds

func _process(delta: float) -> void:
	difficulty = min(difficulty + difficulty_increase * delta, max_difficulty)
