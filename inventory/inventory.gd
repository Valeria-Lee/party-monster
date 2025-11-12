extends Resource

class_name Inventory

@export var items: Array[ItemSlot]
var empty_slots: Array[int]
signal update

func add_item(item:Item):	
	if check_null(items):
		print(items)
		create_slot(0, item)
	else:
		for i in range(items.size()):
			if items[i] != null and items[i].name == item.name:
				items[i].amount += 1
				update.emit()
				return
			else:
				if items[i] == null:
					empty_slots.append(i)
		create_slot(empty_slots[0], item)
		empty_slots.pop_at(0)
	update.emit()

func create_slot(index:int, item:Item):
	items[index] = ItemSlot.new()
	items[index].name = item.name
	items[index].amount = 1
	items[index].item = item

func check_null(arr:Array):
	var isNull: bool = true
	
	for i in range(arr.size()):
		if arr[i] != null:
			isNull = false
			return isNull
	
	return isNull
