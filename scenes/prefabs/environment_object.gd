@tool
class_name EnvironmentObject
extends StaticBody3D

func _ready():
	var mesh_instance = $MeshInstance3D
	var collision_shape = $CollisionShape3D

	if mesh_instance and collision_shape:
		var mesh = mesh_instance.mesh
		if mesh and mesh is BoxMesh:
			# Получаем размеры BoxMesh
			var size = mesh.size
			collision_shape.shape = BoxShape3D.new()
			collision_shape.shape.extents = size / 2  # Половина размера для BoxShape3D
