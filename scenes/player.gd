class_name Player
extends Area3D

const LASER_SHOT = preload("res://scenes/prefabs/laser_shot.tscn")
@onready var steering_component: SteeringComponent = $SteeringComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var move_component: MoveComponent = $MoveComponent

func _ready() -> void:
	health_component.health_depleted.connect(_destroy_player)
	health_component.health_changed.connect(SignalBus.emit_player_health_changed)
	SignalBus.emit_player_health_changed(health_component.current_health)

func shoot():
	var laser = LASER_SHOT.instantiate()
	add_child(laser)

func steer(target: Node3D):
	steering_component.steer(target)

func crash_with(body: Node3D):
	if not body.is_in_group('environment'):
		health_component.take_damage()

func _destroy_player():
	move_component.stop()
	SignalBus.emit_player_destroyed()
