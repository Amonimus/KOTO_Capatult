class_name Selectable
extends Area3D
#region Vars
@onready var scene: Scene = get_tree().get_current_scene()
var animation: AnimationPlayer
var select_ring: Node3D = preload("res://ring.glb").instantiate()
#endregion
#region System
#region System
func _init(pos: Vector3) -> void:
	position = pos

func _ready() -> void:
	create_collision_object()
	mouse_entered.connect(show_ring)
	mouse_exited.connect(hide_ring)
	input_event.connect(input)

func input(_camera, event, _position, _normal, _shape_idx):
	if scene.camera.focus_object != self:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				scene.camera.focus_object = self
				select_ring.visible = false
#endregion
#region Methods
func create_collision_object() -> void:
	var model: Node3D = preload("res://catapult.glb").instantiate()
	model.scale = Vector3(0.5, 0.5, 0.5)
	add_child(model)
	for child in model.get_children():
		if child is AnimationPlayer:
			animation = child
	
	select_ring.scale = Vector3(0.5, 0.5, 0.5)
	add_child(select_ring)
	select_ring.visible = false
	
	var collision: CollisionShape3D = CollisionShape3D.new()
	add_child(collision)
	var shape: BoxShape3D = BoxShape3D.new()
	collision.shape = shape
	collision.shape.size = Vector3(2, 2, 2)

func show_ring():
	if scene.camera.focus_object != self:
		select_ring.visible = true
	
func hide_ring():
	select_ring.visible = false
#endregion
