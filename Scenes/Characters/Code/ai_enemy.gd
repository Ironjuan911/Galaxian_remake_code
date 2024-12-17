extends Node;
class_name AI_Enemy;

@export var right_zone : bool = true;

@onready var node_parent : Node2D= $"..";

const speed_direction : float = 0.5;
var direction : Vector2;
var point_reference : Vector2 = Vector2(71,-125);
var point_objective : Vector2 = point_reference;

@onready var min_range : Vector2 = Vector2(
	-GlobalVariables.base_resolution_center_viewport.x/4 + 10,
	-GlobalVariables.base_resolution_center_viewport.y/6 + 10
)
@onready var max_range : Vector2 = Vector2(
	GlobalVariables.base_resolution_center_viewport.x/4 -10,
	GlobalVariables.base_resolution_center_viewport.y/4 -10
)

func _new_ready() -> void:
	pass;

func _new_process(delta : float) -> void:
	pass;
	
func _ready() -> void:
	_new_ready();

func _physics_process(delta: float) -> void:
	set_direction();
	$"../RayCast2D".rotation = atan2(direction.x,direction.y);
	$"../RayCast2D".scale = Vector2(1,1)*sqrt(direction.x**2+direction.y**2);
	_new_process(delta);
	if start_mode:
		start();
	
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

"""Zone objectives"""

var objective_list : Array[Vector2];
var objective_index : int = 0;
const max_objectives : int = 3;
var start_mode : bool = false;

func set_objectives() -> void:
	if objective_list.is_empty():
		start_mode = false;
		new_objectives();
		
	else:
		next_objective();
		


func new_objectives():
	objective_list.resize(max_objectives);
	objective_index = 0;
	var j= 0;
	while max_objectives-1 >= j:
		await get_tree().process_frame;
		objective_list[j] = Vector2(
			GlobalVariables.create_random_number2(min_range.x,max_range.x),
			GlobalVariables.create_random_number2(min_range.y,max_range.y)
		)
		j += 1;
	objective_list = GlobalVariables.order_vectors_in_x(objective_list);
	if (right_zone):
		objective_list.reverse();

func next_objective():
	point_objective = objective_list[objective_index];
	objective_list.erase(objective_index);
	if objective_index + 1 == max_objectives:
		objective_list.clear();
		point_objective = point_reference;
	else:
		objective_index += 1;

func start() -> void:
	if not start_mode:
		start_mode = true;
		set_objectives();
	
	elif abs(point_objective.x-node_parent.position.x) <= 10 and abs(point_objective.y-node_parent.position.y) <= 10:
		set_objectives();
