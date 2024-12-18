extends Node;

var bullet_data :PackedScene = preload("res://Scenes/Characters/bullets/bullet.tscn");

const meter : int = 8;
const base_resolution_center_viewport : Vector2 = Vector2(460 , 649);
var rng : RandomNumberGenerator = RandomNumberGenerator.new();

func get_vector(arrival_point:Vector2, exit_point:Vector2) -> Vector2: #Adquiere un vector dependiendo de 2 puntos
	var unit_vector = exit_point - arrival_point;
	var lambda = sqrt(unit_vector.x**2+unit_vector.y**2);
	var vector = unit_vector/lambda;
	return vector;

func order_vectors_in_x(Input_array : Array[Vector2]) -> Array[Vector2]:
	for i in range(Input_array.size()):
		for j in range(0, Input_array.size() - i - 1):
			if Input_array[j].x > Input_array[j + 1].x:
				var temp = Input_array[j]
				Input_array[j] = Input_array[j + 1]
				Input_array[j + 1] = temp
	return Input_array;

func create_random_number2(min_number : float, max_number : float) -> float:
	rng.randomize();
	var rd = rng.randf_range(min_number,max_number);
	return rd;

func create_random_number1(number : int) -> int:
	rng.randomize();
	return rng.randi() % number + 1
	
func create_bullet(color:int,up_mode:bool,focus_player:bool,focus_enemy:bool) -> Bullet:
	var bullet : Bullet = bullet_data.instantiate();
	bullet.color_type = color;
	bullet.up_direction_ = up_mode;
	bullet.focused["player"] = focus_player;
	bullet.focused["enemy"] = focus_enemy;
	
	return bullet;

func in_world(_position : Vector2) -> bool:
	return abs(_position.x) >= base_resolution_center_viewport.x/2 or abs(_position.y) >= base_resolution_center_viewport.y/2;
