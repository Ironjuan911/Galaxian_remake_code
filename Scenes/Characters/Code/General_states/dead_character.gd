extends Node;
class_name dead_character;

@onready var character: Character = get_parent().get_parent();
@onready var isFromPlayer : bool = character is Player;
@onready var sprite_dead: Sprite2D = $SpriteDead;
@onready var animation: AnimationPlayer = $AnimationPlayer;

const DEAD_ENEMY : CompressedTexture2D = preload("res://Sprites/dead_character/dead_enemy.png");
const DEAD_PLAYER : CompressedTexture2D = preload("res://Sprites/dead_character/dead_player.png");

func _ready() -> void:
	if isFromPlayer:
		sprite_dead.texture = DEAD_PLAYER;
	else:
		sprite_dead.texture = DEAD_ENEMY;
	
	sprite_dead.visible = false;

func start_state() -> void:
	character.velocity = Vector2(0,0);
	character.sprite.visible = false;
	sprite_dead.visible = true;
	animation.play("Start");

func local_physics_process(delta: float) -> void:
	pass;

func end_state() -> void:
	pass;

func _end() -> void:
	if isFromPlayer:
		GameManager.CreatePlayer();
	character.queue_free();
