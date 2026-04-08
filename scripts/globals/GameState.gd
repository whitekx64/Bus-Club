extends Node

var max_hunger = 100.0
var hunger : float = 100
var max_hp = 100.0
var health : float = 100.0
var max_stamina = 100.0
var stamina :float = 100.0
var can_restore_stamina :bool

var money :int = 0

var hunger_timer : Timer

var damage_timer : Timer

func _ready() -> void:
	GlobalEvent.player_change_hp.connect(_on_hp_changed)
	GlobalEvent.player_change_stamina.connect(_on_stamina_changed)
	GlobalEvent.player_change_money.connect(_on_money_changed)
	GlobalEvent.player_change_hunger.connect(_on_hunger_changed)
	GlobalEvent.player_hunger_damage.connect(_on_hunger_damaged)
	
	
	hunger_timer = Timer.new()
	add_child(hunger_timer)
	hunger_timer.wait_time = 30.0
	hunger_timer.autostart = true
	hunger_timer.connect("timeout", _on_hunger_timer_timeout)
	hunger_timer.start()
	
func _on_hunger_timer_timeout():
	GlobalEvent.player_change_hunger.emit(-5.0)

func _on_hp_changed(amount):
	health = clamp(health + amount, 0, max_hp)

func _on_stamina_changed(amount):
	stamina = clamp(stamina + amount, 0, max_stamina)

func _on_money_changed(amount):
	money = max(money + amount, 0)

func _on_hunger_changed(amount):
	hunger = clamp(hunger + amount, 0, max_hunger)
	if hunger <= 0:
		GlobalEvent.player_hunger_damage.emit()

func _on_hunger_damaged():
	damage_timer = Timer.new()
	add_child(damage_timer)
	damage_timer.wait_time = 3.0
	damage_timer.autostart = true
	damage_timer.connect("timeout", _on_damage_timer_timeout)
	damage_timer.start()

func _on_damage_timer_timeout():
	if hunger <= 0:
		GlobalEvent.player_change_hp.emit(-5)
	else:
		damage_timer.stop()
func _process(delta: float) -> void:
	if can_restore_stamina:
		stamina = move_toward(stamina, max_stamina, 3 * delta)
