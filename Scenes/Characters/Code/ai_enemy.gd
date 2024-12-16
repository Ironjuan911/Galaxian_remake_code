extends Node;
class_name AI_Enemy;

@onready var node_parent : Node2D= $"..";

const speed_direction : float = 0.1;
var direction : Vector2;
var point_reference : Vector2 = Vector2(71,-125);
@onready var point_objective : Vector2 = point_reference;

func _new_process(delta : float) -> void:
	pass;

func _physics_process(delta: float) -> void:
	set_direction();
	$"../RayCast2D".rotation = atan2(direction.x,direction.y);
	$"../RayCast2D".scale = Vector2(1,1)*sqrt(direction.x**2+direction.y**2);
	_new_process(delta);
	
func set_direction() -> void:
	var real_direction : Vector2 = get_direction(point_objective);
	direction = Vector2(
		lerp(direction.x,real_direction.x,speed_direction),
		lerp(direction.y,real_direction.y,speed_direction)
	);

func get_direction(exit_point : Vector2) -> Vector2:
	var vector : Vector2 = GlobalVariables.get_vector(node_parent.position,exit_point);
	if abs(exit_point.x - node_parent.position.x) > 6 or abs(exit_point.y - node_parent.position.y) > 6:
		pass;
	else:
		vector = vector/3
	vector.y = -vector.y;
	return vector;


func start():
	pass;
