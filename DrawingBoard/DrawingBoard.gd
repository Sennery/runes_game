extends Node2D

var buttons = []
var selectedPoints = []

func _ready():
	buttons = [$Point1, $Point2, $Point3, $Point4]

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index != BUTTON_LEFT:
			return
		# Начать рисовать руну по клику
		if event.pressed:
			for i in buttons.size():
				var b = buttons[i]
				if b.get_global_rect().has_point(get_global_mouse_position()):
					selectedPoints = [i+1]
					print_debug("Selected points: ", selectedPoints)
					break
		# Закончить рисовать руну по отжатию
		else:
			if is_drawing():
				print_debug("Selected points: ", selectedPoints)
			selectedPoints = []
	elif event is InputEventMouseMotion:
		# Добавить к руне точки, на которые наводит пользователь
		if is_drawing():
			for i in buttons.size():
				var b = buttons[i]
				var pointId = i + 1
				if (b.get_global_rect().has_point(get_global_mouse_position())
						and !selectedPoints.has(pointId)):
					selectedPoints.append(pointId)
					print_debug("Selected points: ", selectedPoints)
					break

func is_drawing():
	return len(selectedPoints) > 0

