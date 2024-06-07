class_name Projectile
extends Area3D
#region Vars
@onready var scene: Scene = get_tree().get_current_scene()
var is_attached: bool = true
var launch_time: float = 0.0
var start_position: Vector3
var current_machine: Machine = null
var placement_pos = Vector3(0, 0.5, 2.5)
#endregion
#region System
func _init(selectable: Machine):
	attach(selectable)

func _ready():
	input_ray_pickable = false
	var body: CSGSphere3D = CSGSphere3D.new()
	add_child(body)
	body.radius = 0.5
	var collision: CollisionShape3D = CollisionShape3D.new()
	add_child(collision)
	collision.shape = SphereShape3D.new()
	collision.shape.radius = 2
	spawn_light()
	area_entered.connect(_on_area_entered)

func _process(_delta):
	if not is_attached:
		var direction: Vector3 = transform.basis.z * -0.5
		position += direction
		var projection = Vector3(position.x, start_position.y, position.z)
		var distance: float = start_position.distance_to(projection)
		position.y = parabola_trajectory(distance)
		if position.y < -100:
			queue_free()

func _on_area_entered(area: Area3D):
	if not is_attached:
		if area is Machine and area != current_machine:
			if not area.projectile:
				call_deferred("attach", area)
		if area is Goal:
			is_attached = true
#endregion
#region Methods
func attach(machine: Machine):
	if get_parent():
		get_parent().remove_child(self)
	current_machine = machine
	machine.add_child(self)
	machine.projectile = self
	position = placement_pos
	rotation = Vector3.ZERO
	is_attached = true

func spawn_light():
	var light: OmniLight3D = OmniLight3D.new()
	light.omni_range = 30
	light.position = Vector3(0, 1, 0)
	light.light_energy = 20
	#light.omni_attenuation = 2
	add_child(light)

func shoot():
	is_attached = false
	reparent(scene)
	start_position = position

func parabola_trajectory(x: float) -> float:
	var h: float = 5
	var d: float = 25
	var y: float = 4*h * (-(x/d)**2 + x/d)
	return y
#endregion
