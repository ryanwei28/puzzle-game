-----------------------------------------------------------------------------------------
--設計一個拼圖遊戲
-- 遊戲開始後計時
--越短時間內完成者獲勝


--Data: 2016/08/10  09:25
--Author:Ryan
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar ) 
math.randomseed( os.time() )

--=======================================================================================
--宣告各種變數
--=======================================================================================
_SCREEN = {
	W = display.contentWidth ,
	H = display.contentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX ,
	Y = display.contentCenterY
}

local obj
local bgImg
local puzzle1 
local puzzle2
local puzzle3
local puzzle4
local puzzle5
local puzzle6
local puzzle7
local puzzle8
local puzzle9
local puzzle10
local puzzle11
local puzzle12
local puzzle13
local puzzle14
local puzzle15
local puzzle16
local puzzle17
local puzzle18
local puzzle19
local puzzle20
local puzzleBackground
local puzzleFinish
local puzzleGroup
local num = 0  --計算已經完成拼圖初始值
local puzzleFinish
local timeLabel
local min , sec , perSec = 0 , 0 , 0  --加入時間分、秒、百分秒初始值
local tapStart
local complete
local restart 
local soundStart 
local soundCorrect = audio.loadSound( "sounds/correct.mp3" )
local soundMove = audio.loadSound( "sounds/move.mp3")
local soundError = audio.loadSound("sounds/blip2.mp3")
local soundFinish = audio.loadSound("sounds/finish.mp3")
local soundStart = audio.loadSound("sounds/start.mp3")
local soundBgMuisc = audio.loadStream( "sounds/bgmusic.mp3"  )
local tips 
--=======================================================================================
--宣告各個函式名稱
--=======================================================================================
local initial
local touch
local checkPosition
local endGame
local timing
local tapToStart
local restartGame
local tipss
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function ( )
	initial()
end

--=======================================================================================
--定義其他函式
--=======================================================================================
initial = function ( )
	--加入開始圖
	tapStart = display.newImageRect( "images/tapStart.jpg", _SCREEN.W , _SCREEN.H )
	tapStart.x , tapStart.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
	tapStart:addEventListener( "tap", function ( )
		transition.to( tapStart, { time = 1000 , xScale = 5 , yScale = 5 } )
		timer.performWithDelay( 1000, start )
		audio.play( soundStart )
	end )
end

start = function ( )
	--播放背景音樂
	audio.play( soundBgMuisc ,{ channel = 2 , loops = -1 })
	audio.resume( 2 )
	--移除起始圖片
	tapStart:removeSelf( )
	--加入背景圖
	bgImg = display.newImageRect( "images/pink.png", _SCREEN.W , _SCREEN.H )
	bgImg.x , bgImg.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y
	bgImg:addEventListener( "touch", function (event)
		if ( event.phase == "began") or ( event.phase == "moved") then
			display.getCurrentStage( ):setFocus( bgImg )
		elseif (event.phase == "ended") then
			display.getCurrentStage( ):setFocus( nil )
		end
	end )
	--加入拼圖底板
	puzzleBackground = display.newImageRect("images/puzzleBackground.png", _SCREEN.W , 300 )
	puzzleBackground.x , puzzleBackground.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y-50
	puzzleBackground.alpha = 0.45
	--加入拼圖
	puzzle1 = display.newImageRect("images/puzzle1.png" , 84 , 97)
	puzzle1.rightPosition = { x = 42 , y = 89 }
	puzzle1.x , puzzle1.y = 160 , 405
	puzzle1.isVisible = false

	puzzle2 = display.newImageRect("images/puzzle2.png" , 82 , 71)
	puzzle2.rightPosition = { x = 105 , y = 76 }
	puzzle2.x , puzzle2.y = 160 , 405
	puzzle2.isVisible = false

	puzzle3 = display.newImageRect("images/puzzle3.png" , 65 , 71)
	puzzle3.rightPosition = { x = 160 , y = 76 }
	puzzle3.isVisible = false
	puzzle3.x , puzzle3.y = 160 , 405
	
	puzzle4 = display.newImageRect("images/puzzle4.png" , 85 ,97)
	puzzle4.rightPosition = { x = 215 , y = 89 }
	puzzle4.isVisible = false
	puzzle4.x , puzzle4.y = 160 , 405
	
	puzzle5 = display.newImageRect("images/puzzle5.png" , 85 ,97)
	puzzle5.rightPosition = { x = 278 , y = 89 }
	puzzle5.isVisible = false
	puzzle5.x , puzzle5.y = 160 , 405
	
	puzzle6 = display.newImageRect("images/puzzle6.png" , 85 ,103)
	puzzle6.rightPosition = { x = 42 , y = 164 }
	puzzle6.isVisible = false
	puzzle6.x , puzzle6.y = 160 , 405
	
	puzzle7 = display.newImageRect("images/puzzle7.png" , 62.5 ,133)
	puzzle7.rightPosition = { x = 95 , y = 153 }
	puzzle7.isVisible = false
	puzzle7.x , puzzle7.y = 160 , 405
	
	puzzle8 = display.newImageRect("images/puzzle8.png" , 91 ,110)
	puzzle8.rightPosition = { x = 147 , y = 139 }
	puzzle8.isVisible = false
	puzzle8.x , puzzle8.y = 160 , 405
	
    puzzle9 = display.newImageRect("images/puzzle9.png" , 83 ,82)
	puzzle9.rightPosition = { x = 216 , y = 153 }
	puzzle9.isVisible = false
	puzzle9.x , puzzle9.y = 160 , 405
	
	puzzle10 = display.newImageRect("images/puzzle10.png" , 79 ,83)
	puzzle10.rightPosition = { x = 280 , y = 153 }
	puzzle10.isVisible = false
	puzzle10.x , puzzle10.y = 160 , 405
	
	puzzle11 = display.newImageRect("images/puzzle11.png" , 83.5 ,77)
	puzzle11.rightPosition = { x = 42 , y = 232 }
	puzzle11.isVisible = false
	puzzle11.x , puzzle11.y = 160 , 405
	
	puzzle12 = display.newImageRect("images/puzzle12.png" , 63.5 ,98)
	puzzle12.rightPosition = { x = 95 , y = 243 }
	puzzle12.isVisible = false
	puzzle12.x , puzzle12.y = 160 , 405
	
	puzzle13 = display.newImageRect("images/puzzle13.png" , 85 ,103.5)
	puzzle13.rightPosition = { x = 150 , y = 217 }
	puzzle13.isVisible = false
	puzzle13.x , puzzle13.y = 160 , 405
	
	puzzle14 = display.newImageRect("images/puzzle14.png" , 107.5 ,97)
	puzzle14.rightPosition = { x = 226 , y = 221 }
	puzzle14.isVisible = false
	puzzle14.x , puzzle14.y = 160 , 405
	
	puzzle15 = display.newImageRect("images/puzzle15.png" , 63 ,103.5)
	puzzle15.rightPosition = { x = 290 , y = 217 }
	puzzle15.isVisible = false
	puzzle15.x , puzzle15.y = 160 , 405
	
	puzzle16 = display.newImageRect("images/puzzle16.png" , 87 ,94.5)
	puzzle16.rightPosition = { x = 43 , y = 291 }
	puzzle16.isVisible = false
	puzzle16.x , puzzle16.y = 160 , 405
	
	puzzle17 = display.newImageRect("images/puzzle17.png" , 82 ,69.5)
	puzzle17.rightPosition = { x = 104 , y = 303 }
	puzzle17.isVisible = false
	puzzle17.x , puzzle17.y = 160 , 405
	
	puzzle18 = display.newImageRect("images/puzzle18.png" , 67 ,94)
	puzzle18.rightPosition = { x = 159 , y = 291 }
	puzzle18.isVisible = false
	puzzle18.x , puzzle18.y = 160 , 405

	puzzle19 = display.newImageRect("images/puzzle19.png" , 86 ,95.5)
	puzzle19.rightPosition = { x = 215 , y = 290.5 }
	puzzle19.isVisible = false
	puzzle19.x , puzzle19.y = 160 , 405
	
	puzzle20 = display.newImageRect("images/puzzle20.png" , 86 ,96)
	puzzle20.rightPosition = { x = 278 , y = 290 }
	puzzle20.isVisible = false
	puzzle20.x , puzzle20.y = 160 , 405

	--將拼圖名稱加入table
	t = {}
	t[1] = puzzle1
	t[2] = puzzle2
	t[3] = puzzle3
	t[4] = puzzle4
	t[5] = puzzle5
	t[6] = puzzle6
	t[7] = puzzle7
	t[8] = puzzle8
	t[9] = puzzle9
	t[10] = puzzle10
	t[11] = puzzle11
	t[12] = puzzle12
	t[13] = puzzle13
	t[14] = puzzle14
	t[15] = puzzle15
	t[16] = puzzle16
	t[17] = puzzle17
	t[18] = puzzle18
	t[19] = puzzle19
	t[20] = puzzle20

	--用迴圈將20片拼圖加入偵聽器
	for puzzleNum = 1 , 20 do
		t[puzzleNum]:addEventListener( "touch", touch )
	end

	--隨機顯示第一片拼圖
	i = math.random( 1,#t )
	 t[i].isVisible = true
	table.remove( t,i )

	--顯示時間標籤
	timeLabel = display.newText( "Time:".."0:00:00", 50, 20 , system.nativeFont ,20 )
	timeLabel.anchorX = 0
	timeLabel:setFillColor( 0 )
	--開始計時
	timeStart = timer.performWithDelay(1, timing ,-1 )
	------------------------------------------------------------
	-- tips = display.newCircle( 300, 400, 50 )
	-- tips:addEventListener( "tap", tipss )
	------------------------------------------------------------
end
--加入提示功能
-- tipss = function ( )
-- 	display.newCircle(t[i].rightPosition.x , t[i].rightPosition.y, 30)
-- end

--計時函式
timing = function (e)
	perSec = perSec + 3.15     --3.15 為計時器準時調整值(百分秒每次計時觸發增加值)
	if math.round(perSec) >= 100 then
        perSec = 0
        sec = sec + 1  --百分秒到達100後轉化為1秒
        if ( sec == 60 ) then
        	sec = 0
        	min = min + 1 --60秒轉化為1分鐘
        end
    end
    --顯示時間
    timeLabel.text = "Time:"..min..":"..doubleNum(sec)..":"..doubleNum(math.round(perSec))
end

--將計時器改為2位數
doubleNum = function (n)
	if string.len(n) == 1 then
		n = "0"..n
	end
	return n 
end

--讓物件移動函式
touch = function (e)
	obj = e.target
	if (e.phase == "began") then
		display.getCurrentStage( ):setFocus( obj )
		obj.oldX = obj.x 
		obj.oldY = obj.y 
		obj:toFront( )
		print( obj.oldX )
		print( obj.oldY )
		obj.xScale , obj.yScale = 1.3 ,1.3
		audio.play( soundMove )
	elseif (e.phase == "moved") then
		move_x = e.x - e.xStart
		move_y = e.y - e.yStart
		obj.x = obj.oldX + move_x
		obj.y = obj.oldY + move_y
	elseif (e.phase == "ended") then
		display.getCurrentStage( ):setFocus( nil )
		checkPosition(e.target)
		obj.xScale , obj.yScale = 1 ,1
	end
	return true
end

--確認拼圖位置及判斷已經完成幾片拼圖
checkPosition = function ( pic )
	if math.abs( pic.x - pic.rightPosition.x ) < 30
		and  math.abs( pic.y - pic.rightPosition.y ) < 30 then
		--若拼圖位置與正確位置x,y距離30內，則移動到正確位置並移除偵聽
		pic.x , pic.y = pic.rightPosition.x , pic.rightPosition.y
		pic:removeEventListener( "touch", touch )
		audio.play( soundCorrect )
		num = num + 1
		--總共為20片拼圖，1~19片完成後再隨機產生一片
		if (num <= 19 ) then
			i = math.random( 1,#t )
		 	t[i].isVisible = true
		 	t[i].x =150
			table.remove( t,i )
		end
		--完成第20片則結束遊戲
		if (num == 20) then
			endGame()
			audio.play( soundFinish )
		end
	else 
		transition.to( pic, {time = 500 , x = 160 ,y = 405} )
		audio.play( soundError )
	end
end

--結束遊戲
endGame = function (  )
	puzzleFinish = display.newImageRect("images/puzzleFinish.png", _SCREEN.W , 300)
	puzzleFinish.x , puzzleFinish.y = _SCREEN.CENTER.X , _SCREEN.CENTER.Y-50
	timer.cancel( timeStart )
	audio.pause( 2 )
	audio.rewind( soundBgMuisc )
	timer.performWithDelay( 300,function()
		--加入完成圖片
		complete = display.newImageRect("images/complete.png" , 350 , 200 )
		complete.x , complete.y = 190 , 250
		transition.to( complete, {time = 500 , xScale = 0.4 , yScale = 0.4 ,rotation = -20 , onComplete = function ()
			restart = display.newImageRect("images/restart.png", 50 , 50 )
			restart.x , restart.y = 0 , 400 
			transition.to( restart, {time = 800 , x = 160 , rotation = 720 } )
			restart:addEventListener( "tap", restartGame )
		end} )
	end	)
end

tapToStart = function ( )
	
end

restartGame = function (  )
	t = {}
	t[1] = puzzle1
	t[2] = puzzle2
	t[3] = puzzle3
	t[4] = puzzle4
	t[5] = puzzle5
	t[6] = puzzle6
	t[7] = puzzle7
	t[8] = puzzle8
	t[9] = puzzle9
	t[10] = puzzle10
	t[11] = puzzle11
	t[12] = puzzle12
	t[13] = puzzle13
	t[14] = puzzle14
	t[15] = puzzle15
	t[16] = puzzle16
	t[17] = puzzle17
	t[18] = puzzle18
	t[19] = puzzle19
	t[20] = puzzle20
	for puzzleNum = 1 , 20 do
		t[puzzleNum]:removeSelf( )
	end
	bgImg:removeSelf( )
	puzzleBackground:removeSelf( )
	timeLabel:removeSelf( )
	complete:removeSelf( )
	puzzleFinish:removeSelf( )
	restart:removeSelf( )
	initial()
	min , sec ,perSec = 0 , 0 , 0
	num = 0
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
main()




