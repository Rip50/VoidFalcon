class_name Player
extends CharacterBody3D

const LASER_SHOT = preload("res://scenes/prefabs/laser_shot.tscn")
@onready var steering_component: SteeringComponent = $SteeringComponent

func shoot():
	var laser = LASER_SHOT.instantiate()
	add_child(laser)

func steer(target: Node3D):
	steering_component.steer(target)
