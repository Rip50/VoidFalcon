class_name Player
extends CharacterBody3D

const LASER_SHOT = preload("res://scenes/prefabs/laser_shot.tscn")

func shoot():
	var laser = LASER_SHOT.instantiate()
	add_child(laser)
	
