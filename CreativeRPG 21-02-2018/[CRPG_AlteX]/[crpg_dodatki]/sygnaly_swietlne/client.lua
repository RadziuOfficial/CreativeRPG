--[[
@Autor: krampsi
@Zakaz zmiany autora
@Zakaz wykożystywania kodu bez zgody autora.
--]]
--482
local strobo_interval = 10	
local is_strobo_enabled = enable

local flash_interval = 1	

local blink_interval = 20		
local blink_duration = 2		

local car_lights_table = {


[407] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={-0.5, 3.6, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={-0.7, 3.47, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[3]={["pos"]={-0.9, 3.34, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
------------------
[4]={["pos"]={0.5, 3.6, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[5]={["pos"]={0.7, 3.47, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[6]={["pos"]={0.9, 3.34, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
-----
[7]={["pos"]={0.95, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[8]={["pos"]={0.95, 2.6, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[9]={["pos"]={0.95, 2.4, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
---------------
[10]={["pos"]={-0.95, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[11]={["pos"]={-0.95, 2.6, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[12]={["pos"]={-0.95, 2.4, 1.4}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
-----------------
[13]={["pos"]={0.9, -3.83, 0.9}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
----
[14]={["pos"]={1.1, -3.48, 0.96}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[15]={["pos"]={-1.1, -3.48, 0.96}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
-------
[16]={["pos"]={1.1, 0.8, 0.96}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[17]={["pos"]={-1.1, 0.8, 0.96}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
-------
[18]={["pos"]={0.66, 4.2, 0.07}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[19]={["pos"]={-0.66, 4.2, 0.07}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
},
[544] = {["mode"]="led",  ----Karetka P 582 
[1]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=3},
[3]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=5},
[4]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
[5]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=9},
[6]={["pos"]={-0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=11},
---
[7]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=2},
[8]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=4},
[9]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=6},
[10]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[11]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=10},
[12]={["pos"]={0.88, 3.1, 1.6}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=12},

---
[13]={["pos"]={-0.99, -4, -0.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[14]={["pos"]={-0.99, -4, -0.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=2},
[15]={["pos"]={-0.99, -4,-0.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=3},
[16]={["pos"]={-0.99, -4,-0.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=4},
[17]={["pos"]={-0.99, -4,-0.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=5},
--578

},
[499] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={0.8, 3.05, 1.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={-0.85, 3.05, 1.55}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
----
[3]={["pos"]={0.7, -3.6, 1.5}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
----
[4]={["pos"]={0.65, 3.6, 0.07}, ["color"]={0,100,255}, ["size"]=0.15, ["phase"]=7},
[5]={["pos"]={-0.63, 3.6, 0.07}, ["color"]={0,100,255}, ["size"]=0.15, ["phase"]=1},
},

[500] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={-0.6, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={-0.5, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[3]={["pos"]={-0.4, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[4]={["pos"]={-0.3, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
-----
[5]={["pos"]={0.6, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=11},
[6]={["pos"]={0.5, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=11},
[7]={["pos"]={0.4, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=11},
[8]={["pos"]={0.3, 0.2, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=11},
},

--507

[574] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={0.35, 0.5, 1.35}, ["color"]={255, 255, 0}, ["size"]=0.2, ["phase"]=2},
[2]={["pos"]={-0.35, 0.5, 1.35}, ["color"]={255, 255, 0}, ["size"]=0.2, ["phase"]=8},
[3]={["pos"]={0, 0.5, 1.35}, ["color"]={255, 255, 255}, ["size"]=0.2, ["phase"]=6},
},

[498] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={-0.87, 1.96, 2.18}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={0.87, 1.96, 2.18}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
----
[3]={["pos"]={0, -3.97, 2.27}, ["color"]={0,100,255}, ["size"]=0.25, ["phase"]=7},
},
[416] = {["mode"]="lamp",  ----Karetka P 582 
[1]={["pos"]={-0.6, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
[2]={["pos"]={-0.5, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[3]={["pos"]={-0.4, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
------------
[4]={["pos"]={0.6, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
[5]={["pos"]={0.5, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
[6]={["pos"]={0.4, 0.93, 1.25}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
---
[7]={["pos"]={-1.04, -3.6, 1.48}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=7},
[8]={["pos"]={1.04, -3.6, 1.48}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
------------------
[9]={["pos"]={-1.22, -3.36, 1.46}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1},
[10]={["pos"]={1.22, -3.36, 1.46}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=7},

------------------
[11]={["pos"]={-1.2, 0.25, 1.45}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=5},
[12]={["pos"]={1.2, 0.25, 1.45}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=3},

},
[426] = {["mode"]="lamp",  --494
[1]={["pos"]={ -0.75, -1.4, 0.68}, ["color"]={0,120,255}, ["size"]=0.1, ["phase"]=8.0}, 
[2]={["pos"]={ -0.65, -1.4, 0.68}, ["color"]={0,120,255}, ["size"]=0.1, ["phase"]=8.0}, 
[3]={["pos"]={ 0.75, -1.4, 0.68}, ["color"]={0,120,255}, ["size"]=0.1, ["phase"]=2.0}, 
[4]={["pos"]={ 0.65, -1.4, 0.68}, ["color"]={0,120,255}, ["size"]=0.1, ["phase"]=2.0}, 
[5]={["pos"]={ 0, 0.8, 0.3}, ["color"]={0,120,255}, ["size"]=0.3, ["phase"]=10.0}, 

},
[560] = {["mode"]="lamp", 
[1]={["pos"]={ -0.8, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=1}, 
[2]={["pos"]={ -0.7, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=1}, 
[3]={["pos"]={ -0.6, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=1}, 
----
[4]={["pos"]={ 0.8, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=8}, 
[5]={["pos"]={ 0.7, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=8}, 
[6]={["pos"]={ 0.6, -2.3, 0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=8}, 
----
[7]={["pos"]={0, 0.5, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
[8]={["pos"]={0.05, 0.5, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
[9]={["pos"]={-0.05, 0.5, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
---
[10]={["pos"]={-0.3, 2.5, 0.07}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=15}, 
[11]={["pos"]={0.3, 2.5, 0.07}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=15}, 
--
},
[507] = {["mode"]="lamp", 
[1]={["pos"]={0, 0.2, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
[2]={["pos"]={0.05, 0.2, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
[3]={["pos"]={-0.05, 0.2, 0.65}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=5}, 
---
[4]={["pos"]={-0.25, 2.7, -0.05}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=1}, 
[5]={["pos"]={0.25, 2.7, -0.05}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=8}, 
---
[6]={["pos"]={ -0.75, -1.4, 0.6}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=8}, 
[7]={["pos"]={ 0.75, -1.4, 0.6}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=1}, 

},
[421] = {["mode"]="lamp", 
---
[1]={["pos"]={-0.25, 2.7, -0.15}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=1}, 
[2]={["pos"]={0.25, 2.7, -0.15}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=8}, 
---
[6]={["pos"]={ -0.5, -1.4, 0.55}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=8}, 
[7]={["pos"]={ 0.5, -1.4, 0.55}, ["color"]={0,100,255}, ["size"]=0.17, ["phase"]=1}, 

},
[597] = {["mode"]="lamp", 
[1]={["pos"]={0.7, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 
[2]={["pos"]={0.55, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 
[3]={["pos"]={0.4, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 
---------------
[4]={["pos"]={-0.7, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
[5]={["pos"]={-0.55, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
[6]={["pos"]={-0.4, -0.18, 0.92}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
---
[7]={["pos"]={0.35, 2.44, -0.02}, ["color"]={0,100,255}, ["size"]=0.15, ["phase"]=8},
[8]={["pos"]={-0.35, 2.44, -0.02}, ["color"]={0,100,255}, ["size"]=0.15, ["phase"]=1},
},
[598] = {["mode"]="lamp", 
[1]={["pos"]={0.25, 2.75, -0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=1}, 
[2]={["pos"]={-0.25, 2.75, -0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=9}, 
----
[3]={["pos"]={ -0.6, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
[4]={["pos"]={ -0.5, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
[5]={["pos"]={ -0.4, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
-----
[6]={["pos"]={ 0.6, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
[7]={["pos"]={ 0.5, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
[8]={["pos"]={ 0.4, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
},
[596] = {["mode"]="lamp", 
[1]={["pos"]={0.25, 2.75, -0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=1}, 
[2]={["pos"]={-0.25, 2.75, -0.1}, ["color"]={0,100,255}, ["size"]=0.1, ["phase"]=9}, 
----
[3]={["pos"]={ -0.6, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
[4]={["pos"]={ -0.5, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
[5]={["pos"]={ -0.4, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=9}, 
-----
[6]={["pos"]={ 0.6, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
[7]={["pos"]={ 0.5, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
[8]={["pos"]={ 0.4, 0, 0.81}, ["color"]={0,100,255}, ["size"]=0.11, ["phase"]=1}, 
},
[573] = {["mode"]="lamp", 
[1]={["pos"]={0.9, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1}, 
[2]={["pos"]={0.7, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1}, 
[3]={["pos"]={0.5, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1}, 
-----------------
[4]={["pos"]={-0.9, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=7}, 
[5]={["pos"]={-0.7, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=7}, 
[6]={["pos"]={-0.5, 2.8, 1.4}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=7},

[7]={["pos"]={0.9, -3.6, 0.9}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=4},
--
},
[604] = {["mode"]="lamp", 
[1]={["pos"]={ 0.39, 0.33, 0.67}, ["color"]={0,30,255}, ["size"]=0.1, ["phase"]=1}, 
[2]={["pos"]={ 0.5, 0.33, 0.64}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=16}, 
-----
[3]={["pos"]={ -0.39, 0.33, 0.67}, ["color"]={0,30,255}, ["size"]=0.1, ["phase"]=1},

----- 
[4]={["pos"]={ -0.5, 0.33, 0.65}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=16}, 
----
[5]={["pos"]={ -0.06, 0.9, 0.35}, ["color"]={0,70,255}, ["size"]=0.1, ["phase"]=1}, 
[6]={["pos"]={ 0.06, 0.9, 0.35}, ["color"]={0,70,255}, ["size"]=0.1, ["phase"]=16}, 
----
[7]={["pos"]={ 0.46, -1.7, 0.4}, ["color"]={0,70,255}, ["size"]=0.13, ["phase"]=16}, 
[8]={["pos"]={ -0.46, -1.7, 0.4}, ["color"]={0,70,255}, ["size"]=0.13, ["phase"]=1}, 
},

[427] = {["mode"]="lamp", 
[1]={["pos"]={-0.4, 1.1, 1.43}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1}, 
[2]={["pos"]={0.4, 1.1, 1.43}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=9}, 
--
[3]={["pos"]={-0.95, -3.7, 1.3}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=9}, 
[4]={["pos"]={0.95, -3.7, 1.3}, ["color"]={0,100,255}, ["size"]=0.3, ["phase"]=1}, 
},
[579] = {["mode"]="lamp", 
[1]={["pos"]={-0.5, 2.4, 0.1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 
[2]={["pos"]={0.5, 2.4, 0.1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
---
[3]={["pos"]={-0.7, -2.4, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
[4]={["pos"]={0.7, -2.4, 1}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 

},
[418] = {["mode"]="lamp", 
[1]={["pos"]={-0.4, 2.45, -0.23}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 
[2]={["pos"]={0.4, 2.45, -0.23}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
---
[3]={["pos"]={-0.7, -2.2, 0.85}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8}, 
[4]={["pos"]={0.7, -2.2, 0.85}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1}, 

},

[482] = {["mode"]="lamp", 
[1]={["pos"]={ -0.7, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[2]={["pos"]={ -0.6, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
[3]={["pos"]={ -0.5, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=1},
 
 
 [4]={["pos"]={ 0.7, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[5]={["pos"]={ 0.6, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
[6]={["pos"]={ 0.5, 0.9, 0.95}, ["color"]={0,100,255}, ["size"]=0.2, ["phase"]=8},
--
[7]={["pos"]={ -0.25, 0.9, 0.95}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=8},
},
[578] = {["mode"]="lamp", 
[1]={["pos"]={-0.9, 3.8, 1.45}, ["color"]={0,100,255}, ["size"]=0.4, ["phase"]=1}, 
[2]={["pos"]={-0.7, 3.8, 1.45}, ["color"]={0,100,255}, ["size"]=0.4, ["phase"]=1}, 

[3]={["pos"]={0.9, 3.8, 1.45}, ["color"]={0,100,255}, ["size"]=0.4, ["phase"]=8}, 
[4]={["pos"]={0.7, 3.8, 1.45}, ["color"]={0,100,255}, ["size"]=0.4, ["phase"]=8}, 

[5]={["pos"]={-0.4, 3.8, 1.45}, ["color"]={255,0,0}, ["size"]=0.4, ["phase"]=8}, 
},
[490] = {["mode"]="lamp", 

[1]={["pos"]={ -0.65, 0.6, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=1}, 
[2]={["pos"]={ -0.27, 0.6, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=1}, 
[3]={["pos"]={ 0.65, 0.6, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=8}, 
[4]={["pos"]={ 0.27, 0.6, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=8}, 




----482
[7]={["pos"]={ -0.65, -2.5, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=8}, 
[8]={["pos"]={ -0.27, -2.5, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=8}, 
[9]={["pos"]={ 0.65,-2.5, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=1}, 
[10]={["pos"]={ 0.27, -2.5, 1.15}, ["color"]={0,100,255}, ["size"]=0.12, ["phase"]=1}, 


[13]={["pos"]={0.28, 3.15, 0.08}, ["color"]={0,120,255}, ["size"]=0.12, ["phase"]=1}, 
[14]={["pos"]={-0.28, 3.15, 0.08}, ["color"]={0,120,255}, ["size"]=0.12, ["phase"]=8}, 
},
--407
[554] = {["mode"]="lamp", 

[1]={["pos"]={ -0.7, 0.27, 1.09}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=1}, 
},

[413] = {["mode"]="led", 

[1]={["pos"]={-0.5, 0.8, 1.15}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=2}, 
[2]={["pos"]={-0.5, 0.8, 1.15}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=4}, 


[3]={["pos"]={0.5, -2.2, 1.19}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=6}, 
[4]={["pos"]={0.5, -2.2, 1.19}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=8}, 
},

[525] = {["mode"]="lamp", 

[1]={["pos"]={-0.6, -0.5, 1.5}, ["color"]={100,100,0}, ["size"]=0.4, ["phase"]=1}, 
[2]={["pos"]={0.6, -0.5, 1.5}, ["color"]={100,100,0}, ["size"]=0.4, ["phase"]=8}, 
[3]={["pos"]={ -0.97, -2.8, 0.35}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=4}, 


},

 

[455] = {["mode"]="lamp", 

[1]={["pos"]={-0.7, 3.8, 2.4}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=1}, 
[2]={["pos"]={0.7, 3.8, 2.4}, ["color"]={100,100,0}, ["size"]=0.3, ["phase"]=6}, 
[3]={["pos"]={-1, -4.05, 2.1}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=6}, 
[4]={["pos"]={-1, -4.05, 2.}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=6}, 
[5]={["pos"]={-1, -4.05, 1.9}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=6}, 
---
[6]={["pos"]={1, -4.05, 2.1}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=1}, 
[7]={["pos"]={1, -4.05, 2.}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=1}, 
[8]={["pos"]={1, -4.05, 1.9}, ["color"]={100,100,0}, ["size"]=0.15, ["phase"]=1}, 

},

}












--[[ 455    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb

 --bindKey

578
--

-- since 0.8 there are no default lights position, because only emergency and pre-defined vehicles can use lights
--["default"] = {["mode"]="lamp", [1]={["pos"]={0.5, 0, 0.8}, ["color"]={255,0,0}, ["size"]=0.25, ["phase"]=0.0}, [2]={["pos"]={-0.5, 0, 0.8}, ["color"]={0,0,255}, ["size"]=0.25, ["phase"]=10.0}}
--]]

-- do not modify --------------------------------------------
local vehicles = {}
local timers = {}

local base_freq = 50	-- freq of timer for light change

-------------------------------------------------------------
function release_vehicle(vehicle)
	if (isElement(vehicle)) then
		if (is_strobo_enabled) then
			setVehicleOverrideLights ( vehicle, 0)
			setVehicleLightState ( vehicle, 0,  1 )
			setVehicleLightState ( vehicle, 1,  1 )
			setVehicleLightState ( vehicle, 2,  1 )
			setVehicleLightState ( vehicle, 3,  1 )
		end
	end
	if (vehicles[vehicle]~=nil) then	
		-- release the markers
		for key, value in pairs(vehicles[vehicle]["flist"]) do
			destroyElement (value["m"])
		end
		
		vehicles[vehicle] = nil
	end
	if (timers[vehicle]~=nil) then
		-- kill the strobo timer
		killTimer(timers[vehicle])
		timers[vehicle] = nil
		
		if (isElement(vehicle)) then
			if (getElementData( vehicle, "emerlights_source")==getPlayerName(getLocalPlayer())) then
				triggerEvent ( "onPlayerEmergencyLightStateChange", getRootElement(), 0 )
			end
		end
	end
end

function checkForAbility(vehicle)
	local veh_model = getElementModel ( vehicle )
	if (car_lights_table[veh_model]==nil)or(getElementData( vehicle, "emerlights_enabled" )=="false") then
		return false
	end
	return true
end

function strobo_state_update (vehicle)
	-- check for valid vehicle
	if (isElement(vehicle)) then
		if (vehicles[vehicle]==nil) then
			-- check for disallowing to use lights
			-- its enabled by default
			if (checkForAbility(vehicle)==false) then
				release_vehicle(vehicle)
				return
			end
			local veh_model = getElementModel ( vehicle )
			
			--if (car_lights_table[veh_model]==nil) then
			--veh_model = "default"
			--end
			
			local occupant = getVehicleOccupant( vehicle, 0)
			if (getElementType(occupant)=="player") then	-- peds also can use emerlights
				local src = getPlayerName(occupant)
				setElementData( vehicle, "emerlights_source", src, false)
				if (src==getPlayerName(getLocalPlayer())) then
					triggerEvent ( "onPlayerEmergencyLightStateChange", getRootElement(), 1 )
				end
			end
			-- init state variable
			
			vehicles[vehicle] = {}
			vehicles[vehicle]["lstate"] = 0 	-- strobo lights state
			vehicles[vehicle]["fstate"] = 0	-- flash light state
			vehicles[vehicle]["flist"] = {}		-- flash lights list (marker ids)
			
			-- create flash lights

			
			local mode = car_lights_table[veh_model]["mode"]
			if (mode==nil) then
				mode = "lamp"
			end
			
			local coeff = 0
			if (mode=="lamp") then
				coeff = 3.141592654/10.0
			else
				coeff = blink_interval/20.0
			end
			
			vehicles[vehicle]["fmode"] = mode
			if getElementData(vehicle,"vehicle:PSP") or getElementData(vehicle,"vehicle:police") or getElementData(vehicle,"vehicle:PR") or getElementData(vehicle,"data:job") or getElementData(vehicle,"vehicle:duty") then
			for light_id, light_desc in pairs(car_lights_table[veh_model]) do
				if (light_id~="mode") then
					vehicles[vehicle]["flist"][light_id] = {}
					vehicles[vehicle]["flist"][light_id]["m"] = createMarker( 0.0001, 0.0001, 0.0001, "corona", light_desc["size"], light_desc["color"][1], light_desc["color"][2], light_desc["color"][3], 100)
					vehicles[vehicle]["flist"][light_id]["p"] = light_desc["phase"]*coeff
					attachElements ( vehicles[vehicle]["flist"][light_id]["m"], vehicle, light_desc["pos"][1], light_desc["pos"][2], light_desc["pos"][3] )
				end
			end
			end	
		end
		
		-- strobo light
		if (is_strobo_enabled) then
			setVehicleOverrideLights ( vehicle, 2)
			if (vehicles[vehicle]["lstate"]<strobo_interval) then
				setVehicleLightState ( vehicle, 0,  1 )
				setVehicleLightState ( vehicle, 1,  0 )
				setVehicleLightState ( vehicle, 2,  0 )
				setVehicleLightState ( vehicle, 3,  1 )	
			else
				setVehicleLightState ( vehicle, 0,  0 )
				setVehicleLightState ( vehicle, 1,  1 )
				setVehicleLightState ( vehicle, 2,  1 )
				setVehicleLightState ( vehicle, 3,  0 )	 
			end
			if (vehicles[vehicle]["lstate"]>=strobo_interval*2) then
				vehicles[vehicle]["lstate"] = 0
			else
				vehicles[vehicle]["lstate"] = vehicles[vehicle]["lstate"] + 1
			end
		end
		-- flash light --createMarker
		if (vehicles[vehicle]["fmode"]=="lamp") then
		-- lamp mode
			local tmp_fstate = vehicles[vehicle]["fstate"]
			for key, value in pairs(vehicles[vehicle]["flist"]) do
				local R, G, B, A = getMarkerColor( value["m"] )
				setMarkerColor(value["m"], R, G, B, (math.sin(tmp_fstate+value["p"])+1.0)*128.0)
			end
			
			vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] + flash_interval
			
		else
		-- led mode  3
			local tmp_fstate = vehicles[vehicle]["fstate"]

			for key, value in pairs(vehicles[vehicle]["flist"]) do
				local R, G, B, A = getMarkerColor(value["m"])
				-- blinking mode
				local tmp_val = tmp_fstate+value["p"]
				if (tmp_val>blink_interval) then
					tmp_val = tmp_val - blink_interval
				end
				if ((tmp_val>=0)and(tmp_val<blink_duration))or((tmp_val>=blink_duration*6)and(tmp_val<blink_duration*5)) then
					setMarkerColor(value["m"], R, G, B, 255)
				else
					setMarkerColor(value["m"], R, G, B, 0)
				end
			end		
			vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] + 1
			if (vehicles[vehicle]["fstate"]>blink_interval) then
				vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] - blink_interval
			end
		end
	else
		-- if vehicle is no more exists
		release_vehicle(vehicle)
	end
end

-- not used anymore
function stroboLightOn()
    playerVehicle = getPedOccupiedVehicle ( getLocalPlayer()  )  -- get the player's vehicle

	--setElementData( playerVehicle, "emerlights_enabled", "true" )	-- debug
	
    if ( playerVehicle ) then
		-- if player is not a driver
		if (getLocalPlayer()~=getVehicleOccupant( playerVehicle )) then
			--outputChatBox("you're not a driver!")
			return
		end
		
		setStroboLightsOn(playerVehicle, nil)
    end
end

function isStroboLightsOn (vehicle_id)
	if (timers[vehicle_id]) then
		return 1
	else
		return 0
	end
end

function setStroboLightsOn(vehicle_id, value)
    if ( vehicle_id ) then
		if (value==nil) then
			if (isStroboLightsOn(vehicle_id)==1) then
				value = 0
			else
				value = 1
			end;
		end;
		if (value==0) then
			if (timers[vehicle_id]) then
				release_vehicle(vehicle_id)
				end
		end
		if (value==1) then
			if (timers[vehicle_id]) then
				release_vehicle(vehicle_id)
			end
			-- create strobo timer
			timers[vehicle_id] = setTimer ( strobo_state_update, base_freq, 0,  vehicle_id )
		end
    end
end
--vehicle:psp
-- only local effect
function enableStroboLightsMode(source, value)
	if (value=="0")or(value=="false") then
		is_strobo_enabled = false
		outputConsole("Stroboscopic mode disabled")
	else
		if (value=="1")or(value=="true") then
			is_strobo_enabled = true
			outputChatBox("Stroboscopic mode enabled")
		else
			outputChatBox("Usage: strobo 0 or strobo 1  for disable/enable stroboscopic lights mode")
		end
	end
end
addCommandHandler("strobo", enableStroboLightsMode)

-- triggered by server
function setEmerlightsState(value, state)
	local player = getPlayerFromName ( value )
	local vehicle = getPedOccupiedVehicle(player)
	if (vehicle) then
		setStroboLightsOn(vehicle, state)
	end
end
addEvent("setEmerlights", true)
addEventHandler("setEmerlights", getRootElement(), setEmerlightsState)

function requestEmerlights()
	-- check for driver
    playerVehicle = getPedOccupiedVehicle (getLocalPlayer())  -- get the player's vehicle

    if (playerVehicle) then
		-- if player is not a driver
		if (getLocalPlayer()~=getVehicleOccupant( playerVehicle )) then
			--outputChatBox("you're not a driver!")
			return
		end
		if (checkForAbility(playerVehicle)) then
			-- sync
			triggerServerEvent("requestEmerlightChangeState", getLocalPlayer(), 1-isStroboLightsOn(getPedOccupiedVehicle(getLocalPlayer())))
		else
			-- not able to use lights for this vehicle
				--outputChatBox("unknown car!")
		end
    end

end

addCommandHandler("Strobo Light On", requestEmerlights)--stroboLightOn)
bindKey("n", "down", "Strobo Light On")

addEvent("onPlayerEmergencyLightStateChange")
--582