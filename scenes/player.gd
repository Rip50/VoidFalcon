class_name Player
extends CharacterBody3D

const LASER_SHOT = preload("res://scenes/prefabs/laser_shot.tscn")
@onready var steering_component: SteeringComponent = $SteeringComponent
@onready var health_component: HealthComponent = $HealthComponent

func shoot():
	var laser = LASER_SHOT.instantiate()
	add_child(laser)

func steer(target: Node3D):
	steering_component.steer(target)

func crash_with(body: Node3D):
	if not body.is_in_group('environment'):
		health_component.take_damage()
