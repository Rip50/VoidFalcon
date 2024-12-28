class_name LaserBeem
extends Node3D

@export var speed: Vector3 = Vector3(0, 0, -500)
@onready var ray_cast_3d: RayCast3D = %RayCast3D

const SPARKS = preload("res://scenes/particles/sparks.tscn")

func _ready() -> void:
	var timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(queue_free)
	add_child(timer)
	timer.start(3)

func _physics_process(delta: float) -> void:
	self.translate(speed * delta)
	var rid = ray_cast_3d.get_collider_rid()
	if ray_cast_3d.is_colliding():
		var collision_point = ray_cast_3d.get_collision_point()
		var sparks = SPARKS.instantiate()
		sparks.emitting = true
		sparks.one_shot = true
		get_parent().add_child(sparks)
		sparks.global_position = collision_point
		
		queue_free()
	
		
