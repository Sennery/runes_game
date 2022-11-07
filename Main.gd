extends Node

const MOB_TIMER_DEFAULT_WAIT_TIME = 1
const MOB_TIMER_DECREASING_COEF = 0.9
const DIFFICULTY_TIMER_DEFAULT_WAIT_TIME = 1
const DIFFICULTY_TIMER_INCREASING_COEF = 1.15

export(PackedScene) var mob_scene
var score = 0

var size_x
var size_y

func decrease_mob_timer(coef):
	$MobTimer.wait_time *= coef
	$HUDDebug.update_mob_timer($MobTimer.wait_time)	

func increase_difficulty_timer(coef):
	$DifficultyTimer.wait_time += coef
	$HUDDebug.update_difficulty_timer($DifficultyTimer.wait_time)

func reset_mob_timer():
	$MobTimer.wait_time = MOB_TIMER_DEFAULT_WAIT_TIME
	$HUDDebug.update_mob_timer($MobTimer.wait_time)	

func reset_difficulty_timer():
	$DifficultyTimer.wait_time = DIFFICULTY_TIMER_DEFAULT_WAIT_TIME
	$HUDDebug.update_difficulty_timer($DifficultyTimer.wait_time)


func _ready():
	reset_mob_timer()
	reset_difficulty_timer()
	size_x = get_viewport().get_size_override().x
	size_y = get_viewport().get_size_override().y
	
	randomize()

func start_game():
	reset_mob_timer()
	reset_difficulty_timer()
	$MobTimer.start()
	$DifficultyTimer.start()
	for child in self.get_children():
		if (child.has_method("_on_VisibilityNotifier2D_screen_exited")):
			child.queue_free()
	
func game_over():
	$MobTimer.stop()
	$DifficultyTimer.stop()
	$HUD.game_over()
	score = 0
	for child in self.get_children():
		if (child.has_method("_on_VisibilityNotifier2D_screen_exited")):
			child.hitted = true

func hit():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	mob.position.x = randf() * size_x
	mob.position.y = 0
	mob.rotation = 0
	
	var velocity_y = rand_range(200.0, 250.0)
	var velocity_x = ((size_x / 2) - mob.position.x) * 0.5 / (size_y / velocity_y)
	mob.linear_velocity = Vector2(velocity_x, velocity_y)
	
	add_child(mob)	
	mob.connect("game_over", self, "game_over")
	mob.connect("hit", self, "hit")

func _on_DifficultyTimer_timeout():	
	$MobTimer.wait_time *= MOB_TIMER_DECREASING_COEF
	$HUDDebug.update_mob_timer($MobTimer.wait_time)
	$DifficultyTimer.wait_time *= DIFFICULTY_TIMER_INCREASING_COEF
	$HUDDebug.update_difficulty_timer($DifficultyTimer.wait_time)
