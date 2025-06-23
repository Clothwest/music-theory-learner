class_name TimerLabel extends Label

var timer: float = 0.0
var timer_ticked: bool = false
# text
var millisecond: int = 0
var second: int = 0
var minute: int = 0
var hour: int = 0

func _ready() -> void:
	pass

func init() -> void:
	timer = 0.0
	timer_ticked = true

func _physics_process(delta: float) -> void:
	if timer_ticked:
		timer += delta
	millisecond = int(timer * 1000) % 1000
	second = int(timer) % 60
	minute = int(timer) / 60 % 60
	hour = int(timer) / 3600 % 100
	show_s_ms()

func reset() -> void:
	timer = 0.0

func show_s_ms() -> void:
	text = "{0}{1}:{2}{3}{4}".format([second / 10, second % 10, millisecond / 100, millisecond / 10 % 10, millisecond % 10])

func show_s() -> void:
	text = "{0}{1}".format([second / 10, second % 10])

func show_m_s() -> void:
	text = "{0}{1}:{2}{3}".format([minute / 10, minute % 10, second / 10, second % 10])

func show_h_m_s() -> void:
	text = "{0}{1}:{2}{3}:{4}{5}".format([hour / 10, hour % 10, minute / 10, minute % 10, second / 10, second % 10])
