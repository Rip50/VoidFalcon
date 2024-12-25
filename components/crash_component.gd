class_name CrashComponent
extends Node

@export var actor : Node3D
@export var actor_crash_area : Area3D

func _ready() -> void:
	actor_crash_area.body_entered.connect(_on_body_crashed)

func _on_body_crashed(body : Node3D):
	if actor.has_method('crash_with'):
		actor.crash_with(body)
