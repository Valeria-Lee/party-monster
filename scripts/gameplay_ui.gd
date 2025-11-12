extends Control

@onready var money_label = $Money/MoneyAmount
@onready var advice_label = $Advice/AdviceLabel
var advice_displayed: bool

func _ready():
	update_money()
	update_advice()
	advice_displayed = false

func _process(delta):
	update_money()
		
	if Money.money < 40 and advice_displayed == false:
		Manager.advice =  "[center][shake]Don't waste all your money!! You need to buy other things"
		advice_displayed = true
	else:
		if Input.is_action_just_pressed("enter"):
			Manager.advice = ""
			print(Manager.advice)
		
	update_advice()

func update_money():
	money_label.text = "$" + str(Money.money)

func update_advice():
	advice_label.text = Manager.advice
