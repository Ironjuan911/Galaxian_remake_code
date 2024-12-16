extends Node;

const meter : int = 8;
const base_resolution_center_viewport : Vector2 = Vector2(460 , 649);

func get_vector(arrival_point:Vector2, exit_point:Vector2) -> Vector2: #Adquiere un vector dependiendo de 2 puntos
	var unit_vector = exit_point - arrival_point;
	var lambda = sqrt(unit_vector.x**2+unit_vector.y**2);
	var vector = unit_vector/lambda;
	return vector;

func get_random_index(range_delta : float) -> float:
	var min_range : float = 1-range_delta;
	var max_range : float = 1+range_delta;
	return randf_range(min_range,max_range);
	
	
