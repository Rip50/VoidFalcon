class_name LaserShot
extends Node3D


var timer: Timer = Timer.new()

func _ready() -> void:
	timer.one_shot = true
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start(5)
