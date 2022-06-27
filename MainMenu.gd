extends Node2D

onready var add = $Addition
onready var sub = $Subtraction
onready var div = $Division
onready var mul = $Multiplication
onready var ope = get_node("/root/Global")
onready var fontzie = $"tap here"
onready var tween = $Tween
onready var background = $Background
onready var PlusAudi = $PlusAud
onready var MinusAudi = $MinusAud
onready var DivideAudi = $DivideAud
onready var MultiplyAudio = $MultiplyAud
var scene = load("res://instance.tscn")
var ins = scene.instance()

var size1 = Vector2(0.096 , 0.096)
var size2 = Vector2(0.1,0.1)
var position2 = Vector2(185, 1374)
var position1 = Vector2(170, 1374) 

var sc = size2

func _ready():
	add.text += ope.HighScore(1) as String
	sub.text += ope.HighScore(2) as String
	div.text += ope.HighScore(3) as String
	mul.text += ope.HighScore(4) as String
	$RichTextLabel.append_bbcode("[center][img=<80>x<80>]" + "res://rsc/opcoins.png" + "[/img]")
	$coin.text = ope.ReadCoin() as String
	bigger()
	bg()
func _on_TaptoContinue_pressed():
	get_tree().change_scene("res://GameScene.tscn")

func _on_Addition_pressed():
	ope.opBASIS = 1
	PlusAudi.play()

func _on_Subtraction_pressed():
	ope.opBASIS = 2
	MinusAudi.play()

func _on_Division_pressed():
	ope.opBASIS = 3
	DivideAudi.play()

func _on_Multiplication_pressed():
	ope.opBASIS = 4
	MultiplyAudio.play()

func bigger():
	tween.interpolate_property(self, "sc", sc, size1, 0.5,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.interpolate_property(fontzie, "rect_position", position1, position2, 0.5,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.interpolate_property(self, "sc", size1, sc ,0.5,Tween.TRANS_BACK,Tween.EASE_IN, 2)
	tween.interpolate_property(fontzie, "rect_position", position2, position1, 0.5,Tween.TRANS_BACK, Tween.EASE_IN, 2)
	tween.start()

func bg():
	background.add_child(ins)

func _process(delta):
	fontzie.rect_scale = sc
