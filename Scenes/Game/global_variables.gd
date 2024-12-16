extends Node;

const meter : int = 8;
const base_resolution_center_viewport : Vector2 = Vector2(460 , 649);
const max_number : int = 999;

func get_vector(arrival_point:Vector2, exit_point:Vector2) -> Vector2: #Adquiere un vector dependiendo de 2 puntos
	var unit_vector = exit_point - arrival_point;
	var lambda = sqrt(unit_vector.x**2+unit_vector.y**2);
	var vector = unit_vector/lambda;
	return vector;

func get_random_index(range_delta : float) -> float:
	var min_range : float = 1-range_delta;
	var max_range : float = 1+range_delta;
	return randf_range(min_range,max_range);

func order_vectors_in_x(Input_array : Array[Vector2]) -> Array[Vector2]:
	Input_array = Input_array.duplicate();
	var Output_array : Array[Vector2];
	Output_array.resize(Input_array.size());
	
	var i = 0;
	var j = 0;
	var index_min_vector;
	var min_number : int = max_number;
	for vectori in Output_array:
		for vectorj in Input_array:
			if vectorj.x <= min_number:
				min_number = vectorj.x;
				index_min_vector = j;
			
			j +=1
		j = 0;
		Output_array[i] = Input_array[index_min_vector];
		Input_array.erase(index_min_vector);
		i += 1;
		
	return Output_array;
