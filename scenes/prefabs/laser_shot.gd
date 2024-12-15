class_name LaserShot
extends Node3D

@onready var laser: AutoDeleteParticle = $Laser
@onready var laser_2: AutoDeleteParticle = $Laser2

var timer: Timer = Timer.new()

func _ready() -> void:
	timer.one_shot = true
	laser.restart()
	laser_2.restart()
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start(5)
