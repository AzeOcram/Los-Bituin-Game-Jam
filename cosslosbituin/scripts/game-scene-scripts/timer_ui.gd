extends Label


@onready var loopTimer: Timer = $Timer

var current_hour := 1  # starts at 1 PM

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	await get_tree().create_timer(3.0).timeout
	#Start Timer
	loopTimer.wait_time = 15.0
	loopTimer.start()
	
	#Text Timer
	text = str(current_hour) + "PM"
	
	loopTimer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_timer_timeout() -> void:
	if current_hour < 7:
		current_hour += 1
		text = str(current_hour) + " PM"
		loopTimer.start()  # start again for the next 20 seconds
	else:
		get_tree().reload_current_scene()
