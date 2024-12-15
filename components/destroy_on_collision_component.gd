class_name DestroyOnCollisionComponent
extends Node

@export var health: HealthComponent

func on_body_collided(collide: Object):
	health.get_destroyed()
