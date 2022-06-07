extends Node2D

#Color codes used in mixing
var redColourCode = Color("#c72424")
var orangeColourCode = Color("#db9121")
var yellowColourCode = Color("#dbd221")
var greenColourCode = Color("#27d61e")
var mintColourCode = Color("#1ed69f")
var blueColourCode = Color("#274ecf")
var indigoColourCode = Color("#8a27cc")
var pinkColourCode = Color("#c736c0")
var whiteColourCode = Color("#e6e6e6")
var blackColourCode = Color("#292929")

#Gene sequence for Slime

#Alleles
var sizeGene = "aa" 
var sizeGeneDictionary = {"aa": 3.0, "bb": 4.0, "AA": 3.5, "BB": 2.0, "Aa": 3.5, "Bb": 2.0, 
							"ab": 3.5, "aB": 2.0, "bA": 3.5, "AB":2.7}
#a - 3.0 A - 3.5
#b - 4.0 B - 2.0
#aa - 3.0; AA - 3.5; Aa - 3.5; 
#bb - 4.0; BB - 2.0; Bb - 2.0; 
#ab - 3.5; aB - 2.0; bA - 3.5; AB - 2.7
#genes that dominate dictate the variable, when both have the same strength, the value is average
var bodyColourGene = "rr"
var colourGeneDictionary = {"R": Color("#c72424"), "Y": Color("#dbd221"), "B": Color("#1ed69f"), "I": Color("#8a27cc"), "W": Color("#e6e6e6")}

#r - red; R - orange; Y - yellow; y - green; b - blue; B - mint; I - indigo; i - pink; W - white; w - black.
# Same Group - any combination - just mixed together
# Different Group - homo recessive - just mixed together
# Different Group - hetero - mixed together + added dominant basic colour
# Different Group - homo dominant - mix together + added more dominant in hierarchy basic colour
var colourGeneHierarchy = {"W": 1, "I": 2, "B": 3, "Y":4, "R":5}
#Dominant hierarchy:
# W > I > B > Y > R 

#Rr - red + orange mixed -> mixed with red
#Ib - indigo + blue mixed -> mixed with indigo
#BW - white + mint mixed -> mixed with white
var eyeColourGene = "rr"
#same rules as above

#Specific atributes from the alleles
export var size = 3.0
#Colours, that will be mixed together
export var bodyColour = Color("#c72424") #basic slime colour
export var eyeColour = Color("#c72424") #eye colour
export var bodyDetailColour_1 = Color("#c72424")
export var bodyDetailColour_2 = Color("#c72424")

func _ready():
	pass
	

func printS():
	print("D")

func inherit(firstParent, secondParent):
	#Genes are selected randomly from each parent and given to the baby
	var temp_P1 = firstParent.getSizeGene()
	var temp_P2 = secondParent.getSizeGene()
	setSizeGene(String(temp_P1[randi()% len(temp_P1)] + temp_P2[randi()% len(temp_P2)]))
	temp_P1 = firstParent.getBodyColourGene()
	temp_P2 = secondParent.getBodyColourGene()
	setBodyColourGene(String(temp_P1[randi()% len(temp_P1)] + temp_P2[randi()% len(temp_P2)]))
	temp_P1 = firstParent.getEyeColourGene()
	temp_P2 = secondParent.getEyeColourGene()
	setEyeColourGene(String(temp_P1[randi()% len(temp_P1)] + temp_P2[randi()% len(temp_P2)]))
	
	#The genes now be transfered to specific values
	#Size - read from dictionary
	setSizeGeneValue(sizeGeneDictionary[sizeGene])
	#Colours - mix genes from the parents and then, based on genes mix with basic colour or not
	temp_P1 = firstParent.getBodyColour()
	temp_P2 = secondParent.getBodyColour()
	var mixedColour = temp_P1.blend(temp_P2)
	setBodyColourGene(String(firstParent.getBodyColourGene()[randi()% len(firstParent.getBodyColourGene())] + secondParent.getBodyColourGene()[randi()% len(secondParent.getBodyColourGene())]))
	if ( (getBodyColourGene()[0].to_lower() == getBodyColourGene()[1].to_lower()) 
	|| (getBodyColourGene()[0].isRecessive() 
	&& getBodyColourGene()[1].isRecessive())):
	#they are the same group or they are both recessive. Mixed Colour is unchanged.
		print("No change");
	elif (((getBodyColourGene()[0].isRecessive())
	&& !getBodyColourGene()[1].isRecessive()) 
	||  (!getBodyColourGene()[0].isRecessive() 
	&& getBodyColourGene()[1].isRecessive())):
	#if diff + hetero blend with dominant colour
		var tempDominant = getDominant(getBodyColourGene()[0], getBodyColourGene()[1])
		var tempDominantColour = colourGeneDictionary[tempDominant]
		mixedColour = mixedColour.blend(tempDominantColour)
	else:
	#if diff + homo dom, check more dominant colour, blend
		var tempDominant = getHierarchyDominant(getBodyColourGene()[0], getBodyColourGene()[1])
		var tempDominantColour = colourGeneDictionary[tempDominant]
		mixedColour = mixedColour.blend(tempDominantColour)
	setBodyColourValue(mixedColour)

func isRecessive(data):
	if (data == data.to_lower()):
		return true
	return false;
func getDominant(data1, data2):
	if (!data1.isRecessive()):
		return data1
	else:
		return data2
func getHierarchyDominant(data1, data2):
	if (colourGeneHierarchy[data1] < colourGeneHierarchy[data2]):
		return data1
	else:
		return data2
func getEyeColourGene():
	return eyeColourGene
func getBodyColourGene():
	return bodyColourGene
func getBodyColour():
	return bodyColour
func getSizeGene():
	return sizeGene
func getSizeGeneValue():
	print(size)
	return size
func setSizeGeneValue(data):
	size = data
func setSizeGene(data):
	sizeGene = data
func setBodyColourGene(data):
	bodyColourGene = data
func setEyeColourGene(data):
	eyeColourGene = data
func setBodyColourValue(data):
	bodyColour = data
