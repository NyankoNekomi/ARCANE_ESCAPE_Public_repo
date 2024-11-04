extends Node

@export_range(0,1) var drop_percent:float = 0.5
@export var health_component : healthComponent
@export var vialscene :PackedScene

func _ready():
	health_component.died.connect(on_died)
	
func on_died():
	if randf()>drop_percent:
		return
	
	if vialscene == null:
		return
	if not owner is Node2D:
		return
		
	var spawn_pos = (owner as Node2D).global_position
	var vial_instance = vialscene.instantiate() as Node2D
	call_deferred("_add_vial_instance", vial_instance, spawn_pos)

func _add_vial_instance(vial_instance: Node2D, spawn_pos: Vector2):
	owner.get_parent().add_child(vial_instance)
	vial_instance.global_position = spawn_pos
	
