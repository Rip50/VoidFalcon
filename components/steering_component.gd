class_name SteeringComponent
extends Node

@export var actor: Node3D
@export var steering_speed: float = 1.0
var target: Node3D

func steer(target: Node3D):
	self.target = target

func _physics_process(delta: float) -> void:
	if target == null:
		actor.rotation = Vector3.ZERO
		return
		
	if abs(target.position.x - actor.position.x) <= 1:
		target = null
		return
		
	actor.look_at(target.position)
	
	var current_position = actor.position
	# Smoothly move the X position towards the target's X
	current_position.x = lerp(current_position.x, target.position.x, steering_speed * delta)
	actor.position = current_position
