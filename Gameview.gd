extends ColorRect

var op1
var op2
var Counter:int = 1 
var rng = RandomNumberGenerator.new()
var scvalue:int
var hp
onready var c1 = get_node("Choice1")
onready var c2 = get_node("Choice2")
onready var c3 = get_node("Choice3")
onready var pb = get_node("ProgressBar")
onready var tm = get_node("Timer")
onready var score = get_node("score")
onready var GOO = get_parent().get_node("GameOverOption")
onready var tween = $Tween
onready var taptap = $StartAudi
var progress
onready var ope = get_node("/root/Global").opBASIS as String

onready var t = get_parent().get_node("Tween")
var opacit

func _ready():
	taptap.play()
	uplevel(Counter)
	get_node("/root/Global").Ghost(t, self, "opacit")

func _on_Choice1_pressed():

	checkanswer(c1.text as int)

	pass # Replace with function body.


func _on_Choice2_pressed():
	
	checkanswer(c2.text as int)
	
	pass # Replace with function body.


func _on_Choice3_pressed():
	
	checkanswer(c3.text as int)
	
	pass # Replace with function body.


func uplevel(var counter):
	rng.randomize()
	
	if ope == "3":
		op1 = 2
		op2 = 23
		while op1 < op2 || op1%op2 !=0:
			op1 = rng.randi_range(2*counter , 7*counter) as int
			op2 = rng.randi_range(1*counter , 3*counter) as int

	elif ope == "4":
		op1 = rng.randi_range(1 , counter+2) as int
		op2 = rng.randi_range(1 , counter+2) as int
	else:
		op1 = rng.randi_range(1*counter , 5*counter) as int
		op2 = rng.randi_range(1*counter , 5*counter) as int
	
	progress  = {"1": op1 as String + " + " + op2 as String, 
	"2": op1 as String + " - " + op2 as String, 
	"3": op1 as String + " / " + op2 as String, 
	"4": op1 as String + " x " + op2 as String }
	get_node("Problem").text = progress[ope]
	
	progress  = {"1": op1 + op2, "2": op1 - op2, "3": op1 / op2, "4": op1 * op2 }
	
	putanswer()

	Counter += 1
	pass
	
func checkanswer(ans):
	var realans = progress[ope]
	
	if(realans != ans):
		tm.stop()
		GOO.visible = true
	else:
		var pbvalue: int = pb.value
		pbvalue += 60 + (Counter * 10)
		#pb.value += 60 + (Counter/2 * 15)   
		updatepb(pbvalue) 
		scvalue += 100 + ((pb.value/6) * Counter)
		score.text = "Score: " + scvalue as String
		uplevel(Counter)
	
	pass
	
func putanswer():
	var a:int = rng.randi_range(1, 3)
	var rand1 = rng.randi_range(1,2)
	var answer = progress[ope] as String
	
	c1.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3) + a) as String
	c2.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3) + rand1 + a) as String
	c3.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3)) as String
	
	while(c1.text == answer):
		c1.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3) + a) as String
	while(c2.text == c1.text || c2.text == answer):
		c2.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3) + rand1 + a) as String
	while(c3.text == c2.text || c3.text == c1.text || c3.text == answer):
		c3.text = (rng.randi_range(progress[ope] -3, progress[ope] + 3)) as String
	
	match a:
		1:
			c1.text = answer
		2:
			c2.text = answer
		_:
			c3.text = answer

func _on_Timer_timeout():
	if pb.value == 0:
		GOO.visible = true
	else:
		pb.value -= (Counter * 0.1) + 1
		hp = pb.value

func _on_GameOverOption_visibility_changed():
	if GOO.visible == false:
		tm.start()
		pb.value = 1500

func updatepb(new_value):
	tween.interpolate_property(self, "hp", hp, new_value, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
func _process(delta):
	pb.value = hp

