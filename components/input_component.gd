class_name InputComponent
extends Node

@export var aim_and_fire_component: AimAndFireComponent

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:  # Check if the event is a key press
		var letter = event.as_text().to_lower() # TODO: hack, fix it
		if letter.length() == 1:
			aim_and_fire_component.process_input(letter)
