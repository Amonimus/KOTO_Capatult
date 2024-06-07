class_name Goal
extends Selectable
#region Methods
func create_collision_object() -> void:	
	var model: Node3D = preload("res://ring.glb").instantiate()
	model.scale = Vector3(0.5, 0.5, 0.5)
	add_child(model)
	
	var collision: CollisionShape3D = CollisionShape3D.new()
	add_child(collision)
	var shape: SphereShape3D = SphereShape3D.new()
	collision.shape = shape
	collision.shape.radius = 2
	
	spawn_light()
	
func spawn_light():
	var light: OmniLight3D = OmniLight3D.new()
	light.omni_range = 30
	light.position = Vector3(0, 1, 0)
	light.light_energy = 20
	#light.omni_attenuation = 2
	add_child(light)
#endregion
