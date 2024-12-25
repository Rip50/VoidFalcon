class_name FollowingCamera
extends Camera3D

var shake_intensity: float = 0.2  # Maximum offset for position (in units)
var shake_duration: float = 0.5  # Duration of the shake (in seconds)
var shake_timer: float = 0.0  # Tracks remaining shake time
@onready var original_offset: Vector3 = self.position  # Store the original camera offset

func _ready() -> void:
	# TODO: replace shaking on enemy destroyed with shaking on explosion
	SignalBus.enemy_destroyed.connect(_shake_on_explosion)

func _shake_on_explosion(position: Vector3):
	# TODO: use distance to enemy for dynamic intensity 
	shake(0.2, 0.5)

func shake(intensity: float, duration: float):
	shake_intensity = intensity
	shake_duration = duration
	shake_timer = duration
	original_offset = self.position  # Save the original relative position

func _process(delta: float):
	if shake_timer > 0:
		shake_timer -= delta
		
		# Generate random offsets for shake (local space relative to player)
		var offset_x = randf_range(-shake_intensity, shake_intensity)
		var offset_y = randf_range(-shake_intensity, shake_intensity)
		var shake_offset = Vector3(offset_x, offset_y, .0)
		
		# Apply the shake offset while preserving original offset
		position = original_offset + shake_offset
	else:
		# Reset to the original offset after shaking ends
		position = original_offset
