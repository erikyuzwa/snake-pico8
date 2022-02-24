pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- snake game
-- fun for the whole family

-- global variables
x={}
y={}
x_dir=0
y_dir=0
score=0

-- we are splitting up our screen into tiles
-- the larger the tile_num, the larger the game area
tile_num=32
tile_size=128/tile_num

fruit={}
fruit.x=0
fruit.y=0
fruit.color=8

function update_fruit()
 fruit.x=flr(rnd(tile_num))*tile_size
 fruit.y=flr(rnd(tile_num))*tile_size 
end


function update_input()
 --btn(0) left
 --btn(1) right
 --btn(2) up
 --btn(3) down
 
 if(btn(0)) then
  x_dir=-1
  y_dir=0
 elseif(btn(1)) then
  x_dir=1
  y_dir=0
 elseif(btn(2)) then
  x_dir=0
  y_dir=-1
 elseif(btn(3)) then
  x_dir=0
  y_dir=1
 end
end


function update_snake()
 
 -- local temp variables
 local temp1x = x[1]
 local temp1y = y[1]
 local temp2x, temp2y
 
 -- update snake head segment
 x[1] += (x_dir * tile_size)
 y[1] += (y_dir * tile_size)
 
 -- update snake tail segments
 for i=2,#x do
  temp2x=x[i]
  temp2y=y[i]
  
  x[i]=temp1x
  y[i]=temp1y
  
  temp1x=temp2x
  temp1y=temp2y
 end
 
end


function draw_fruit()
 rectfill(fruit.x,fruit.y,fruit.x+tile_size-1,fruit.y+tile_size-1,fruit.color)
end

function draw_score()
 color(10)
 print("score: "..score,1,1)
end

function draw_snake()
 rectfill(x[1],y[1],x[1]+tile_size-1,y[1]+tile_size-1,10)
  
 for i=2,#x do
  rectfill(x[i],y[i],x[i]+tile_size-1,y[i]+tile_size-1,3)
 end
  
end

function is_fruit_collision()
 if(x[1]+(x_dir*tile_size) == fruit.x and y[1]+(y_dir*tile_size) == fruit.y) then
   return true
 end
 return false
end

function is_wall_collision()
 if(x[1] > 128 or x[1] < 0 or y[1] < 0 or y[1] > 128) then
  return true
 end
 return false
end

function _init()

 x[1]=tile_size*(tile_num/4)
 y[1]=tile_size*(tile_num/2)

 -- start off moving right
 x_dir=1
 
 -- set default snake tail
 for i=2,7 do
  x[i]=((x[i-1]/tile_size)-1)*tile_size
  y[i]=y[1]
 end
 
 -- place our fruit
 update_fruit()
end

function _update()

 -- check for wall collision
 if(is_wall_collision()) then
  return
 end

 --capture input
 update_input()
 
 local collide=false
 collide=is_fruit_collision()
 if(collide)then
  -- increment score
  score=score+10
  
  -- push new snake tail
  for i=#x+1,2,-1 do
   x[i]=x[i-1]
   y[i]=y[i-1]
  end
  
  x[1]=fruit.x
  y[1]=fruit.y
  update_fruit()
 else
  update_snake()
 end
end

function _draw()
 cls(1)
 draw_snake()
 draw_fruit()
 draw_score()
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
