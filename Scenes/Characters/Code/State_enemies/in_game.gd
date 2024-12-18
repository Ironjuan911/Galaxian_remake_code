extends Node2D

var _attack_mode : bool = false;

func local_physics_process(delta : float) -> void:
	attacking();

func attack_mode() -> void:
	_attack_mode = true;

func attacking() -> void:
	if _attack_mode:
		var bullet : Bullet = GlobalVariables.create_bullet(0,false,true,false);
		get_parent().get_parent().add_sibling(bullet);
		bullet.position = get_parent().get_parent().position;
		_attack_mode = false;
