extends AI_Enemy;
class_name AI_Enemy_1;

var rng : RandomNumberGenerator = RandomNumberGenerator.new();

var objective_list : Array[Vector2];
var objective_index : int = 0;
const max_objectives : int = 3;

var start_mode : bool = false;

@onready var min_range : Vector2 = Vector2(
	-GlobalVariables.base_resolution_center_viewport.x/4 + 10,
	-GlobalVariables.base_resolution_center_viewport.y/8 + 10
)
@onready var max_range : Vector2 = Vector2(
	GlobalVariables.base_resolution_center_viewport.x/4 -10,
	GlobalVariables.base_resolution_center_viewport.y/4 -10
)

func _ready() -> void:
	pass;

func _new_process(delta : float) -> void:
	if start_mode:
		start();
	pass;

func set_objectives() -> void:
	print(objective_list);
	if not objective_list.is_empty():
		point_objective = objective_list[objective_index];
		objective_list.erase(objective_index);
		if objective_index + 1 == max_objectives:
			objective_list.clear();
			point_objective = point_reference;
		else:
			objective_index += 1;

	
	if objective_list.is_empty():
		start_mode = false;
		objective_list.resize(max_objectives);

		objective_index = 0;
		var j= 0;
		while max_objectives-1 >= j:
			await get_tree().process_frame;
			objective_list[j] = Vector2(
				create_random_number(min_range.x,max_range.x),
				create_random_number(min_range.y,max_range.y)
			)
			j += 1;
		#objective_list = GlobalVariables.order_vectors_in_x(objective_list);
	
func create_random_number(min_number : float, max_number : float) -> float:
	rng.randomize();
	var rd = rng.randf_range(min_number,max_number);
	print(rd);
	return rd;
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_attack"):
		print("start");
		start();

	
func start() -> void:
	if not start_mode:
		start_mode = true;
		set_objectives();
	
	if abs(point_objective.x-node_parent.position.x) <= 10:
		set_objectives();
