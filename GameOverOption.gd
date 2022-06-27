extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = get_node("Timer")
onready var timeview = get_node("timerview")
var timevalue:int = 5
onready var ope:int = get_node("/root/Global").opBASIS
onready var g = get_parent().get_node("Ghosttxt")
onready var gbl = get_node("/root/Global")
onready var costlbl = $Cost
onready var tween = $Tween
var trans = 0
var cost:int
var counter = 1


func _ready():
	cost = counter * 20
	costlbl.text = cost as String
	timeview.text = timevalue as String

func _on_Continue_pressed():
	g.text = "-" + costlbl.text
	Checkost()
	fadingcost()
func _on_Timer_timeout():
	if timevalue == 0:
		checkHS()
		#get_parent().get_node("res://MainMenu.tscn/MainMenu").save(23)
		timer.stop()
		timevalue = 5
		get_tree().change_scene("res://MainMenu.tscn")
	else:
		timevalue -= 1
	timeview.text = timevalue as String


func _on_GameOverOption_visibility_changed():
	if get_parent().get_node("GameOverOption").visible == true:
		timer.set_wait_time(1)
		timer.start()
	else:
		pass
	pass # Replace with function body.

func _on_GiveUp_pressed():
	checkHS()
	timer.stop()
	timevalue = 10
	get_tree().change_scene("res://MainMenu.tscn")

func checkHS():
	var score:int = get_parent().get_node("GameAddition/score").text as int
	var GB = get_node("/root/Global")
	GB.AddCoin(score)
	if GB.HighScore(ope) < score:
		GB.save(score, ope)
	else:
		pass

func Checkost():
	if gbl.ReadCoin() < cost as int:
		get_tree().change_scene("res://MainMenu.tscn")
	else:
		gbl.MinusCoin(cost)
		counter += 1
		cost = (counter * 20.6) as int
		costlbl.text = cost as String
		get_parent().get_node("GameOverOption").visible = false
		timer.stop()
		timevalue = 5
		timeview.text = timevalue as String

func fadingcost():
	tween.interpolate_property(self, "trans", 1, 0, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
func _process(delta):
	g.modulate.a = trans
