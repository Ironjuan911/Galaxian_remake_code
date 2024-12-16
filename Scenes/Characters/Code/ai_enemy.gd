extends Node;
class_name AI_Enemy;

@onready var node_parent : Node2D= $"..";

const speed_direction : float = 0.2;
var direction : Vector2;
var real_direction : Vector2;
var point_reference : Vector2;

func _physics_process(delta: float) -> void:
	
	if (Input.is_action_pressed("ui_attack")):
		point_reference = get_tree().get_first_node_in_group("player").position;
	else:
		point_reference = Vector2(0,0);
	
	real_direction = get_direction(point_reference);
	direction = Vector2(
		lerp(direction.x,real_direction.x,speed_direction),
		lerp(direction.y,real_direction.y,speed_direction)
	);
	
	$"../RayCast2D".rotation = atan2(direction.x,direction.y);
	pass;
	
func get_direction(exit_point : Vector2) -> Vector2:
	var vector = GlobalVariables.get_vector(node_parent.position,exit_point);
	vector.y = -vector.y;
	return vector;
	
	
