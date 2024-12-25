class_name GameManager
extends Node

var score: int = 0

@onready var game_container: Node = $GameContainer
@onready var ui_container: CanvasLayer = $UIContainer

var current_scene: Node = null
var gui: Gui = null

func _ready():
	# TODO: create Game Over screen instead of immediate restart
	SignalBus.player_destroyed.connect(_restart_game)
	SignalBus.enemy_destroyed.connect(_get_score)
	SignalBus.player_health_changed.connect(_refresh_health)
	load_ui("res://ui/gui.tscn")
	load_scene("res://scenes/game.tscn")

func load_scene(path: String):
	if current_scene:
		current_scene.queue_free()
	var scene = (load(path) as PackedScene).instantiate()
	game_container.add_child(scene)
	current_scene = scene

func load_ui(path: String):
	gui = (load(path) as PackedScene).instantiate()
	ui_container.add_child(gui)

func _restart_game():
	# TODO: fix bug where score is set to 1 when game is restarted after player 
	# gets destroyed by crashing into an enemy 
	score = 0
	load_scene("res://scenes/game.tscn")

func _get_score(_position: Vector3):
	score += 1
	gui.set_score(score)

func _refresh_health(health: int):
	gui.set_health(health)
