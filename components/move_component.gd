class_name MoveComponent
extends Node

@export var actor: Node3D
@export var velocity: Vector3

func _physics_process(delta) -> void:
	var motion = velocity * delta
	actor.translate(motion)
