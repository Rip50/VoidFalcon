class_name CrashComponent
extends Node

@export var actor : Node3D
@export var actor_crash_area : Area3D

func _ready() -> void:
	actor_crash_area.area_entered.connect(_on_area_crashed)

func _on_area_crashed(area : Area3D):
	if actor.has_method('crash_with'):
		actor.crash_with(area)
