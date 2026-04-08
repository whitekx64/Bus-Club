extends Node

var max_hp = 100.0
var health = 100.0
var max_stamina = 100.0
var stamina :float = 100.0
var can_restore_stamina :bool

var money :int = 0

func _ready() -> void:
	GlobalEvent.player_change_hp.connect(_on_hp_changed)
	GlobalEvent.player_change_stamina.connect(_on_stamina_changed)
	GlobalEvent.player_change_money.connect(on_money_changed)

func _on_hp_changed(amount):
	health = clamp(health + amount, 0, max_hp)

func _on_stamina_changed(amount):
	stamina = clamp(stamina + amount, 0, max_stamina)

func on_money_changed(amount):
	money = max(money + amount, 0)

func _process(delta: float) -> void:
	if can_restore_stamina:
		stamina = move_toward(stamina, max_stamina, 3 * delta)
