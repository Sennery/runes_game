extends CanvasLayer

signal decrease_mob_timer
signal reset_mob_timer
signal increase_difficulty_timer
signal reset_difficulty_timer

const DECREASE_MOB_TIMER_COEF = 0.5
const INCREASE_DIFFICULTY_TIMER_COEF = 1

func _ready():
	$MobTimerDecreaseButton.text = '*' + str(DECREASE_MOB_TIMER_COEF)
	$DifficultyTimerIncreaseButton.text = '+' + str(INCREASE_DIFFICULTY_TIMER_COEF)

func update_mob_timer(timer):
	$MobTimerLabel.text = 'Mob Timer - ' + str(timer)

func update_difficulty_timer(timer):
	$DifficultyTimerLabel.text = 'Difficulty Timer - ' + str(timer)


func _on_MobTimerResetButton_pressed():
	emit_signal('reset_mob_timer')


func _on_MobTimerDecreaseButton_pressed():
	emit_signal('decrease_mob_timer', DECREASE_MOB_TIMER_COEF)


func _on_DifficultyTimerResetButton_pressed():
	emit_signal('reset_difficulty_timer')


func _on_DifficultyTimerIncreaseButton_pressed():
	emit_signal('increase_difficulty_timer', INCREASE_DIFFICULTY_TIMER_COEF)
