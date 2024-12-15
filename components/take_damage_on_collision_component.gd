class_name TakeDamageOnCollisionComponent
extends Node

@export var health: HealthComponent

func on_body_collided(collide: Object):
	health.take_damage()
