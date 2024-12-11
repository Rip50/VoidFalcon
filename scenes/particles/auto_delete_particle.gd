class_name AutoDeleteParticle
extends GPUParticles3D

func _ready() -> void:
	self.finished.connect(queue_free)
