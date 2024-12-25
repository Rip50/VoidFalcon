class_name Cleaner
extends Area3D

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group('enemies') or area.is_in_group('bonuses'):
		area.queue_free()
