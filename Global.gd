extends Node

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"addition":0,"subtraction":0,"division":0,"multiplication":0,"coins":0} #variable to store data
var opBASIS:int = 1

func _ready():
	if not savegame.file_exists(save_path):
		create_save()
	#var dir = Directory.new()
	#dir.remove("user://savegame.save")
	
func create_save():
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func save(high_score, operation):    
	match operation:
		1:
			save_data["addition"] = high_score #data to save
		2:
			save_data["subtraction"] = high_score #data to save
		3:
			save_data["division"] = high_score #data to save
		_:
			save_data["multiplication"] = high_score #data to save

	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

func HighScore(operation):
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	match operation:
		1:
			return save_data["addition"]
		2:
			return save_data["subtraction"]
		3:
			return save_data["division"]
		_:
			return save_data["multiplication"]

func AddCoin(amount):
	save_data["coins"] += (amount * .001) as int
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func ReadCoin():
	savegame.open(save_path, File.READ)
	save_data = savegame.get_var()
	savegame.close()
	return save_data["coins"]
	
func MinusCoin(amount):
	save_data["coins"] -= amount
	savegame.open(save_path, File.WRITE)
	savegame.store_var(save_data)
	savegame.close()

func Ghost(tween, obj, strs):
	tween.interpolate_property(obj, strs, 1 , 0, 3, Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
