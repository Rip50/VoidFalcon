class_name Cleaner
extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('enemies') or body.is_in_group('bonuses'):
		body.queue_free()
