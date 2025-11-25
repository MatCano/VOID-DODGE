extends Node

var game_started := false
@onready var press_label := $UI/PressLabel
@onready var ui_layer := $UI

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	if ui_layer:
		ui_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	if press_label:
		press_label.process_mode = Node.PROCESS_MODE_ALWAYS

	# Show label and pause the tree
	get_tree().paused = true
	if press_label:
		press_label.visible = true

func _input(event) -> void:
	if game_started:
		return

	if event.is_action_pressed("ui_accept"):
		start_game()

func start_game() -> void:
	game_started = true
	if press_label:
		press_label.visible = false
	get_tree().paused = false
