class_name Camera
extends Node3D
#region Vars
@onready var camera: Camera3D = Camera3D.new()
var focus_object: Selectable = null
var camera_distance: int = 8
var camera_angle: float = - PI / 4
#endregion
#region System
func _ready() -> void:
	add_child(camera)

func _process(_delta: float) -> void:
	camera_pivot()
	keyboard()
#endregion
#region System
func camera_pivot() -> void:
	if focus_object:
		var direction: Vector3 = focus_object.transform.basis.z * camera_distance / 2
		position = focus_object.position + direction
		position.y = camera_distance
		rotation = Vector3(camera_angle, focus_object.rotation.y, 0)

func keyboard() -> void:
	if Input.is_key_pressed(KEY_A):
		if focus_object:
			focus_object.rotation.y += 0.05
	if Input.is_key_pressed(KEY_D):
		if focus_object:
			focus_object.rotation.y -= 0.05
	if Input.is_key_pressed(KEY_SPACE):
		if focus_object:
			focus_object.shoot()
#endregion
