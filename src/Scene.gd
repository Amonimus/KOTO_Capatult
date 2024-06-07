class_name Scene
extends Node3D
#region Vars
@onready var camera: Camera = Camera.new()
#endregion
#region System
func _ready() -> void:
	add_child(camera)
	#spawn_light()
	make_level()
	RenderingServer.set_default_clear_color(Color.BLACK)
	var obj: Goal = Goal.new(Vector3(0, 0, -55))
	add_child(obj)

#endregion
#region Methods
func spawn_object(pos: Vector3) -> Machine:
	var obj: Machine = Machine.new(pos)
	add_child(obj)
	return obj

func spawn_light():
	var light: OmniLight3D = OmniLight3D.new()
	light.position = Vector3(0, 8, 0)
	light.omni_range = 30
	light.light_energy = 20
	light.omni_attenuation = 2
	add_child(light)

func make_level():
	var obj: Machine = spawn_object(Vector3(0, 0, 0))
	obj.create_projectile()
	camera.focus_object = obj
	spawn_object(Vector3(16, 0, -16))
	spawn_object(Vector3(-4, 0, -32))
#endregion
