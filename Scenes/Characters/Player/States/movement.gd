extends Node;

var direction : Vector2;

const meter : int  = GlobalVariables.meter;
var speed : int = 15;

@onready var player: Player = $"../..";

func local_physics_process(delta: float) -> void:
	direction = Input.get_vector("ui_left","ui_right","ui_down","ui_up")
	
	if (direction.x != 0 or direction.y != 0):
		general_movement(delta);
	else:
		idle_movement(delta);
	#print("x: " + str(direction_x) + ", y: " + str(direction_y));
	pass;

func general_movement(delta: float) -> void:
	
	player.velocity.x = lerp(player.velocity.x,meter*speed*delta*direction.x,0.05);
	player.velocity.y = lerp(player.velocity.y,-meter*speed*delta*direction.y,0.05);
	
func idle_movement(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x,0.0,0.1);
	player.velocity.y = lerp(player.velocity.y,0.0,0.1);
	pass
