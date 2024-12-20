extends Node;

@onready var player: Player = $"../..";
@onready var timer_state: Timer = $Timer_state
@onready var timer_particle: Timer = $Timer_particle

@onready var dash_animation_data : PackedScene = preload("res://Scenes/Characters/Player/dash.tscn");

@export var dash_speed = 30;
var meter = GlobalVariables.meter;

var enabled : bool = false;
var dash_direction : Vector2; 

func start_state() -> void:
	dash_direction = player.all_state_node["in_game"].direction;
	dash_direction = Vector2(
		round(dash_direction.x),
		-round(dash_direction.y)
	);
	if (dash_direction.x == 0 and dash_direction.y == 0):
		dash_direction.y = -1;
	
	enabled = true;
	timer_state.start();
	timer_particle.start();

func local_physics_process(delta: float) -> void:
	dash_movement(delta);
	

func dash_movement(delta:float) -> void:
	if (abs(dash_direction.x) == 1 and abs(dash_direction.y) == 1):
		player.velocity = dash_speed*meter*dash_direction*delta;
	else:
		player.velocity = dash_speed*meter*dash_direction*1.3*delta;

func _on_timer_state_timeout() -> void:
	if enabled:
		end_state();
		player.admin_states.movement();

func end_state() -> void:
	enabled = false;
	timer_particle.is_stopped();
	timer_state.is_stopped();
	
	

func _on_timer_particle_timeout() -> void:
	if enabled:
		var dash_animation : Node2D = dash_animation_data.instantiate();
		player.add_sibling(dash_animation);
		dash_animation.position = player.position;
		dash_animation.animation.play("disappear");
