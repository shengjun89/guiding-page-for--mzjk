# Create a new PageComponent and only allow horizontal scrolling. 
page = new PageComponent
    width: Screen.width
    height: Screen.height
    scrollVertical: false
    backgroundColor: "#fff"
 
 
page.content.draggable.bounceOptions =
    friction: 32,
    tension: 1000,
    tolerance: 1
    

imagesrc = ["images/title01@2x.png","images/title02@2x.png","images/title03@2x.png"]
picsrc = ["images/pic01@2x.png","images/pic02@2x.png","images/pic03@2x.png"]

# Create 5 new layers and add them to the page.content 
for number in [0...3]
    pageContent = new Layer
        width: page.width
        height: page.height
        x: page.width * number
        backgroundColor: "#f4f4f4"
# 	    backgroundColor:"#f4f4f4"
        parent: page.content
 		
    # Visualize the current page number 
#     pageContent.html = pageContent.html = number + 1
 
    # Center the current page number 
    pageContent.style =
        "font-size" : "100px",
        "font-weight" : "100",
        "text-align" : "center",
        "line-height" : "#{page.height}px"

    pic = new Layer
     parent:pageContent
     width: Screen.width*0.72
     x: Align.center
     y: 96
     height: Screen.height*0.22
     backgroundColor: null
     image: imagesrc[number]



#指示器
allIndicators=[]   
for number in [0...3]
    indicator = new Layer
     backgroundColor:"#0d6cb0"
     width: 18,height: 18
     x: (page.width/20)*number+page.width/2-40
     y: page.height-64
     borderRadius: "50%", opacity: 0.2
     
    indicator.states.add(active: {opacity: 1})
    indicator.states.animationOptions = time: 0.5
    allIndicators.push(indicator)

	
#插图灰色底
bg = new Layer
	width: Screen.width*0.66
	x: Align.center
	height: Screen.width*0.8
	y: Align.center
	backgroundColor: null
	image: "images/bg@2x.png"
	clip: true

#计时器仪表盘
zz = new Layer
	parent: bg
	backgroundColor: null
	image: "images/zz@2x.png"
	z: 1
	width: bg.width*0.28
	height: bg.width*0.28
	x: Align.center
	y: Align.center


#计时器仪表盘添加旋转事件
zz.states.add
	on:
		rotation:180
		options:
			curve:Spring(damping: 0.2)
	
	off:
		rotation:0
		options:
			curve:Spring(damping: 0.2)

#支付宝印戳
zfb = new Layer
	width: 200
	height: 200
	image: "images/parts04@2x.png"
	x: Align.center(Screen.width*0.05)
	y: bg.y+bg.height*0.5
	scale: 2
	opacity: 0

#金币
coin = new Layer
	width: 120
	height: 110
# 	x: 72
# 	y: 800
	scale: 1.6
	x: -420
	y: 300
	opacity:0
	backgroundColor: null
	image: "images/coin.png"

coin1 = new Layer
	width: 64
	height: 64
	scale: 1.2
# 	x: Screen.width-180
	x: Screen.width+340
	backgroundColor: null
	image: "images/coin.png"
	rotationY:0
	rotation: 90
# 	y: bg.y+200
	y: bg.y+20
	opacity: 0
	
	
coin2 = new Layer
	scale: 1.6
	width: 85
	height: 80
# 	x: Screen.width-300
	x: Screen.width+120
	backgroundColor: null
	image: "images/coin.png"
	scale: 0.8
	rotationX:0
	rotationY:0
	rotation: 90
	y: bg.y+140
	opacity: 0

btn = new Layer
	x: Align.center
	y: Align.bottom(-96)
	z: 3
	scale: 0.6
	backgroundColor: "transparent"
	width: Screen.width
	height: Screen.width*0.3
	image: "images/btn.png"
	opacity: 0




pics=[]

for i in [0...3]
	pic = new Layer
		parent: bg
		backgroundColor: null
		x: Align.center
		width:bg.width*0.6
		height: bg.width
		image: picsrc[i]
		z: 1
		y: 520
		opacity: 0

	pic.states.add
		on:
			y: 80
			opacity:1
			options:
				curve: Spring(damping: 0.5)
				time: 0.5
				
		off:
			y: 520
			opacity:0
			options:
				curve: Spring(damping: 0.5)
				time: 0.5		

	pics.push(pic)
	pics[0].states.switch("on")
	
# pic02 = new Layer
# 	parent: bg
# 	backgroundColor: null
# 	x: Align.center
# # 	y: 50
# 	y: 800
# 	width: Screen.width/3.2
# 	height: Screen.width*0.65
# 	image: "images/pic02@2x.png"
# 	z: 1
# 
# 
# pic03 = new Layer
# 	parent: pic01
# 	backgroundColor: null
# 	x: Align.center
# # 	y: 50
# 	y: 800
# 	width: Screen.width/2
# 	height: Screen.width*0.65
# 	image: "images/pic03@2x.png"
# 	z: 1
partssrc=["images/parts01@2x.png","images/parts02@2x.png","images/parts03@2x.png"]
parts = []

for i in [0...partssrc.length]
	partspic = new Layer
		width: 0.8*Screen.width
		height: 0.6*Screen.width
		x: Align.center
		y: bg.y
	# 	opacity: 1
# 		scale:0.8
		opacity: 0
		image: partssrc[i]
	
		
		
	partspic.states.add
		on:
			scale:1
			opacity:1
			options:
				curve:Spring(damping: 0.3)	
				time:0.4
				delay:0.24
				
		off:
			scale:0.7
			opacity:0
			options:
				curve:Spring(damping: 0.2)	
				time:0.2
				delay:0.24		
	
	parts.push(partspic)

parts[0].scale = 1
parts[0].opacity = 1
	
# print allIndicators
allIndicators[0].opacity = 1
page.animationOptions = curve:"cubic-bezier(0.19, 1, 0.22, 1)"
# Update indicators
page.on "change:currentPage", ->
	current = page.horizontalPageIndex(page.currentPage)
	indicator.states.switch("default") for indicator in allIndicators
	allIndicators[current].states.switch("active")	
	pic.states.switch("off") for pic in pics
	pics[current].states.switch("on")
	partspic.states.switch("off") for partspic in parts
	parts[current].states.switch("on")	
# 	
# 
page.on Events.Move, ->
	scrolltoX(page.scrollX)
# 	print page.scrollX

scrolltoX = (x) ->
	zz.rotation = Utils.modulate(x,[0,Screen.width],[0,180],false)
	zz.opacity = Utils.modulate(x,[0,Screen.width],[1,0],false)
	coin.x = Utils.modulate(x,[0,Screen.width],[-420,96],false)
	coin.y = Utils.modulate(x,[0,Screen.width],[300,620],false)
	coin.opacity = Utils.modulate(x,[0,Screen.width],[0,1],false)
	coin.opacity = Utils.modulate(x,[Screen.width,Screen.width*2],[1,0],false)
	coin.scale = Utils.modulate(x,[0,Screen.width],[1.6,1],false)
	
	coin1.x = Utils.modulate(x,[0,Screen.width],[Screen.width+340,Screen.width-180],false)
	coin1.y = Utils.modulate(x,[0,Screen.width],[bg.y+20,bg.y+120],false)
	coin1.opacity = Utils.modulate(x,[0,Screen.width],[0,1],false)
	coin1.opacity = Utils.modulate(x,[Screen.width,Screen.width*2],[1,0],false)	
	coin1.scale = Utils.modulate(x,[0,Screen.width],[1.2,1],false)
	
	coin2.x = Utils.modulate(x,[0,Screen.width],[Screen.width+120,Screen.width-300],false)
	coin2.y = Utils.modulate(x,[0,Screen.width],[bg.y+140,bg.y+240],false)
	coin2.opacity = Utils.modulate(x,[0,Screen.width],[0,1],false)
	coin2.opacity = Utils.modulate(x,[Screen.width,Screen.width*2],[1,0],false)
	coin2.scale = Utils.modulate(x,[0,Screen.width],[1.6,1],false)
	btn.opacity = Utils.modulate(x,[Screen.width,Screen.width*2],[0,1],false)
	
	
	zfb.scale = Utils.modulate(x,[Screen.width,Screen.width*2],[2,0.4],false)
	zfb.opacity = Utils.modulate(x,[Screen.width,Screen.width*2],[0,1],false)