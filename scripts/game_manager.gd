class_name GameManager
extends Node

@onready var game_container: Node = $GameContainer
@onready var ui_container: CanvasLayer = $UIContainer

var current_scene: Node = null

func _ready():
	load_scene("res://scenes/game.tscn")
	load_ui("res://scenes/ui.tscn")

func load_scene(path: String):
	if current_scene:
		current_scene.queue_free()
	var scene = (load(path) as PackedScene).instantiate()
	add_child(scene)
	current_scene = scene

func load_ui(path: String):
	var ui_scene =  (load(path) as PackedScene).instantiate()
	ui_container.add_child(ui_scene)
