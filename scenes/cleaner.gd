class_name Cleaner
extends Area3D

func _on_body_entered(body: Node3D) -> void:
	body.queue_free()
