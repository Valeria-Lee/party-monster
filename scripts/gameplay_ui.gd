extends Control

@onready var money_label = $Money/MoneyAmount
@onready var advice_label = $Advice/AdviceLabel
@onready var payment_label = $Cart/PaymentAmount
var advice_displayed: bool

func _ready():
	update_money()
	update_advice()
	advice_displayed = false

func _process(delta):
	update_money()
	update_payment()
		
	if Money.money < 40 and advice_displayed == false:
		Manager.advice =  "[center][shake]Don't waste all your money!! You need to buy other things"
		advice_displayed = true
	else:
		if Input.is_action_just_pressed("enter"):
			Manager.advice = ""
			print(Manager.advice)
		
	update_advice()

func update_payment():
	payment_label.text = "$" + str(Money.cart_payment)

func update_money():
	money_label.text = "$" + str(Money.money)

func update_advice():
	advice_label.text = Manager.advice
