pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
-- snake game!
-- good for beginners
x={}
y={}
x_dir=0
y_dir=0
grid_size=128
tile_num=32
tile_size=grid_size/tile_num
score=0

fruit_x=0
fruit_y=0
fruit_color=8

function draw_fruit()
 rectfill(fruit_x,fruit_y,fruit_x+(tile_size-1),fruit_y+(tile_size-1),fruit_color)
end
 

function draw_snake()
 for i = 1, #x do
   rectfill(x[i],y[i],x[i]+tile_size-1,y[i]+tile_size-1,3)
 end
   
end

function draw_score()
 color(10)
 print("score: "..score,1,1)
end

function do_input()
 if(btn(0) and (not(x_dir==1 and y_dir==0))) then
   --move left
   x_dir=-1
   y_dir=0
 elseif(btn(1) and (not(x_dir==-1 and y_dir==0))) then
   --move right
   x_dir=1
   y_dir=0
 elseif(btn(2) and (not(x_dir==0 and y_dir==1))) then
   --move up
   x_dir=0
   y_dir=-1
 elseif(btn(3) and (not(x_dir==0 and y_dir==-1))) then
   --move down
   x_dir=0
   y_dir=1
 end
end

function update_fruit()
 --randomly place the fruit
 fruit_x = flr(rnd(tile_num))*tile_size
 fruit_y = flr(rnd(tile_num))*tile_size
end

function update_snake()
 local tempx = x[1]
 local tempy = y[1]
 local temp1x, temp1y
 
 x[1] += (x_dir * tile_size)
 y[1] += (y_dir * tile_size)
 
 for i=2,#x do
  temp1x = x[i]
  temp1y = y[i]
  
  x[i]=tempx
  y[i]=tempy
  
  tempx=temp1x
  tempy=temp1y
 end
end  


function _init()

x[1]=tile_size*(tile_num/4)
y[1]=tile_size*(tile_num/2)

update_fruit()

end

function _update()
 do_input()
 update_snake()
end

function _draw()
  cls()
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
