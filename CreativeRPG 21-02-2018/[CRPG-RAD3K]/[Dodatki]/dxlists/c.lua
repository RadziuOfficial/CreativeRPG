--[[
Autor: Asper && <nie znajomy>
Typ: Client
]]

local screen_size = { guiGetScreenSize( ) } 
local screenW, screenH = guiGetScreenSize()

function dxDrawButton(x, y, w, h, color)
  local color2 = tocolor(0,94,254)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x-0.4660164, y + h-1.6, w+1.5, 2, color2, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 3, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 3, color, false)
end

function roundedRectangle(x, y, w, h, color)
  dxDrawRectangle(x, y, w, h, color, false)
  dxDrawRectangle(x + 2, y - 1, w - 4, 1, color, false)
  dxDrawRectangle(x + 2, y + h, w - 4, 1, color, false)
  dxDrawRectangle(x - 1, y + 2, 1, h - 4, color, false)
  dxDrawRectangle(x + w, y + 2, 1, h - 4, color, false)
end

dxGrid          =   { items = {} };
local cursorOn;

local NATIVE_RESOLUTION		=	{ nil } -- put your screen resolution here to fit the gridlists to all resolutions (ex: { 1366, 768 } )
if ( table.maxn ( NATIVE_RESOLUTION ) == 2 ) then
	FIT_MODE				=	true
	RES                   	=   { guiGetScreenSize() };
	X,Y                   	=   RES[1] / NATIVE_RESOLUTION[1], RES[2] / NATIVE_RESOLUTION[2];
	SCALE                 	=   ( 1 / NATIVE_RESOLUTION[1] ) * RES[1];
end

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Core - functions

local gridlist = {}

function dxCreate(x, y, width, height, i)
    gridlist[i] = dxGrid:Create(x, y, width, height, false)
end

function dxAddColumn(i, text, width)
    gridlist[i]:AddColumn(text, width)
end

function dxAddItem(ix, text, i)
    gridlist[i]:AddItem(ix, text)
end

function dxDestroy(i, x)
	gridlist[i]:Destroy()
end

function dxItemDetails(i, x)
	local s = gridlist[i]:GetSelectedItem()
	if tonumber(s) < 1 then
		return false
	else
		local showed = gridlist[i]:GetItemDetails(x, s)
		return showed
	end
end

function dxGrid:Create ( x, y, width, height, postGUI )
    -- table dxGrid:Create ( int x, int y, int width, int height[, bool postGUI ] )

    if __checkParams ( "Create", "nnnn", x, y, width, height ) then
        local data = {
            x       =       FIT_MODE and ( x * X ) or x;                                -- X position
            y       =       FIT_MODE and ( y * Y ) or y;                                -- Y position
            w       =       FIT_MODE and ( width * X ) or width;                        -- Width
            h       =       FIT_MODE and ( height * Y ) or height;                      -- Height
            pg      =       postGUI or false;                                           -- PostGUI
            i       =       {};                                                         -- Items
            mi      =       __calcMaxItems ( FIT_MODE and ( height * Y ) or height );   -- Max items
            s       =       1;                                                          -- Scroll Level
            r       =       -1;                                                         -- Row count
            se      =       -1;                                                         -- Selected item
            mo      =       nil;                                                        -- Mouse-on item
            vis     =       true                                                        -- Visible
        };

        setmetatable ( data, { __index = dxGrid } );
        table.insert ( dxGrid.items, data );

        return data;
    end
end

function dxGrid:Destroy ()
    -- bool dxGrid:Destroy ()

    for k, v in pairs ( dxGrid.items ) do
        if v == self then
            dxGrid.items[k] = nil;
            return true;
        end
    end
    return false;
end

function dxGrid:SetVisible ( visible )
    -- bool Gridlist:SetVisible ( bool state )
    
    if __checkParams ( "SetVisible", "b", visible ) then
        self.vis = visible

        return true
    else
        return false
    end
end

function dxGrid:IsVisible ( )
    -- bool Gridlist:IsVisible()

    return self.vis
end

function dxGrid:AddColumn ( title, width )
    -- int Gridlist:AddColumn ( string title, int width )

    if __checkParams ( "AddColumn", "sn", title, width ) then
        local data = {
            info    =   { title = title, width = FIT_MODE and ( width * X ) or width }
        };

        table.insert ( self.i, data );

        return #self.i;
    end
end

function dxGrid:RemoveColumn ( columnIndex )
    -- bool Gridlist:RemoveColumn ( int columnIndex )

    if __checkParams ( "RemoveColumn", "n", columnIndex ) then
        self.i[columnIndex] = nil;

        -- Recalculate the highest item count
        local highest = -1;

        for _, v in ipairs ( self.i ) do
            if #v > highest then
                highest = ( #v - 1 );
            end
        end

        self.r = highest;

        -- Recalculate the scroll level (if necessary)
        if ( ( ( self.s + self.mi ) - 2 ) == self.r ) then
            self.s = ( self.r - self.mi ) + 1;
        end

        return true
    end
    return false
end

function dxGrid:GetColumnCount ()
    -- int Gridlist:GetColumnCount()

    return #self.i
end

function dxGrid:RemoveItem ( column, itemID )
    -- bool Gridlist:RemoveItem ( int columnIndex, int itemIndex )

    if __checkParams ( "RemoveItem", "nn", column, itemID ) then
        if self.i[column] and self.i[column][itemID] then
            -- Recalculate the highest item count
            if self.r == #self.i[column] then
                local highest = -1;

                for _, v in ipairs ( self.i ) do
                    if #v > highest then
                        highest = ( #v - 1 );
                    end
                end

                self.r = highest;
            end

            -- Recalculate the scroll level (if necessary)
            if ( ( ( self.s + self.mi ) - 2 ) == self.r ) then
                self.s = ( self.r - self.mi ) + 1;
            end

            -- Reset the selected item if necessary²
            if itemID == self.se then
                local newItem   =   self.se - 1

                if newItem <= self.r then
                    self.se = math.max ( 0, newItem );
                else
                    self.se = -1
                end
            end

            table.remove ( self.i[column], itemID );

            return true;
        end
        return false
    end
end

function dxGrid:GetItemCount ( columnID )
    -- int Gridlist:GetItemCount ( int columnIndex )

    if __checkParams ( "GetItemCount", "n", columnID ) then
        if self.i[columnID] then
            return #self.i[columnID]
        end
        return false
    end
end

function dxGrid:Clear ()
    -- bool Gridlist:Clear()

    for k, v in ipairs ( self.i ) do
        self.i[k] = { info = v.info }
    end

    self.r = -1
    self.se = nil

    -- Recalculate the scroll level
    self.s = 1;

    return true
end

function dxGrid:GetSelectedItem ( )
    -- int Gridlist:GetSelectedItem ()

    return self.se;
end

function dxGrid:SetSelectedItem ( itemID )
    -- bool Gridlist:SetSelectedItem ( int itemIndex )

    if __checkParams ( "SetSelectedItem", "n", itemID ) then
        if itemID <= self.r then
            self.se = itemID;
            return self.se == itemID;
        end
        return false;
    end
end

function dxGrid:GetItemDetails ( column, itemID )
    -- string, mixed Gridlist:GetItemDetails ( int columnIndex, int itemIndex )

    if __checkParams ( "GetItemDetails", "nn", columnID, itemID ) then
        if self.i[column] then
            if self.i[column][itemID] then
                return self.i[column][itemID].text, self.i[column][itemID].data
            end
        end
        return false
    end
end

function dxGrid:AddItem ( columnIndex, text, data, r, g, b )
    -- int Gridlist:AddItem ( int columnIndex, string title[, mixed data, int r, int g, int b ] )

    if __checkParams ( "AddItem", "ns", columnIndex, text ) then
        if self.i[columnIndex] then	
            local tColor = __checkRGB ( r, g, b ) and { r, g, b } or { 255, 255, 255 };
			
            table.insert ( self.i[columnIndex], { id = #self.i[columnIndex] + 1, text = tostring( text ), data = data, color = tColor } );

            if #self.i[columnIndex] > self.r then
                self.r = #self.i[columnIndex];
            end

            return #self.i[columnIndex];
        end
        return false;
    end
end

local ss = 0
local font = dxCreateFont(":crpg_fonty/f.ttf", 13)

function colores_gsub(text)
    return text:gsub("#%x%x%x%x%x%x","")
end

local ustawione = false

addEventHandler ( "onClientRender", root, function()
if screenW < 1000 and ustawione ~= true then
    ss = 0.6
    ustawione = true
elseif screenW > 1000 and screenW < 1500 and ustawione ~= true then
    ss = 0.8
    ustawione = true
elseif screenW > 1500 and screenW < 1750 and ustawione ~= true then
    ss = 1
    ustawione = true
else
	if ustawione ~= true then
   	 	ss = 1
   	 	ustawione = true
    end
end
        -- Is there any gridlist to render?
        if #dxGrid.items > 0 then
            -- Loop through all grid lists
            for index, data in ipairs ( dxGrid.items ) do
                -- Is the gridlist visible?
                if data.vis then
                    -- Draw the 'gridlist' itself
                    dxDrawButton ( data.x, data.y-5, data.w, data.h+5, tocolor ( 50,50,50,200 ), data.pg );

                    -- Draw the column bar
                    dxDrawRectangle ( data.x, data.y-5, data.w, 30 % data.h, tocolor ( 0,94,254,125 ), data.pg );

                    -- Set cursorOn variable to the current gridlist, if it's selected
                    cursorOn = nil
                    if __isMouseInPosition ( data.x, data.y, data.w, data.h ) then
                        cursorOn = index
                    end

                    -- Check if there's any selected item
                    local seeFrom   =   data.s;
                    local seeTo     =   ( data.s + data.mi ) - 1;

                    if data.se and data.se <= data.r and data.se >= seeFrom and data.se <= seeTo then
                        local index     =   data.se - ( data.s - 1 );
                        local y2        =   data.y + ( ( index - 1 ) * 25 );

                        -- Draw a rectangle to make it looks like selected
                        roundedRectangle ( data.x, ( 30 % data.h ) + y2, data.w, 20, tocolor ( 0, 0, 0, 100 ), data.pg );
                    end

                    -- Is there any column?
                    if #data.i > 0 then
                    local cWidth = 0

                        -- Loop through all columns
                        for cIndex, cData in ipairs ( data.i ) do
                            -- we'll go beyond the gridlist width with this column ?
                            if ( ( cWidth + cData.info.width ) <= data.w ) then
                                local x = data.x + cWidth;

                                -- Draw the column title
                                dxDrawText ( cData.info.title, x, data.y-5+1, cData.info.width + x, ( 30 % data.h ) + data.y+1, tocolor ( 0, 0, 0 ), ss, font, "center", "center", false,false,true )
                                dxDrawText ( cData.info.title, x, data.y-5, cData.info.width + x, ( 30 % data.h ) + data.y, tocolor ( 255, 255, 255 ), ss, font, "center", "center", false,false,true )

                                -- Reset the selected item
                                cData.info.selected = -1;

                                -- Is there any item ?
                                if #cData > 0 then
                                    local seeFrom   =   data.s;
                                    local seeTo     =   ( data.s + data.mi ) - 1;

                                    -- Loop the items
                                    for iIndex = seeFrom, seeTo do
                                        -- There's a row with this index in the current column?
                                        if cData[iIndex] then
                                            local index     =   iIndex - ( data.s - 1 );
                                            local y         =   data.y + ( index * 25 );
                                            local y2        =   data.y + ( ( index - 1 ) * 25 );

                                            -- Check if cursor is on item position
                                         --   if __isMouseInPosition ( data.x, ( 30 % data.h ) + y2, data.w, 20 ) then
                                         		if __isMouseInPosition(data.x, ( 30 % data.h ) + y2, data.w, 20) then
                                                -- Define the mouse-on variable
                                                data.mo = iIndex;
                                            end

                                            -- Draw the item text
                                            roundedRectangle ( data.x, ( 30 % data.h ) + y2, data.w, 20, tocolor ( 0, 0, 0, 25 ), data.pg );
                                            dxDrawText ( colores_gsub(cData[iIndex]["text"]), x+1, y+1, cData.info.width + x+1, ( 30 % data.h ) + y+1, tocolor ( 0, 0, 0 ), ss, font, "center", "center", false,false,true )
                                            dxDrawText ( cData[iIndex]["text"], x, y, cData.info.width + x, ( 30 % data.h ) + y, tocolor ( 255, 255, 255 ), ss, font, "center", "center", false,false,true )
                                        end
                                    end
                                end

                                -- Increase cWidth variable (to draw the columns correctly)
                                cWidth = cWidth + cData.info.width;
                            end
                        end
                    end
                end
            end
        end
    end
, true, "low-5")

--

addEventHandler ( "onClientKey", root,
    function ( button, press )
        -- Is cursor showing?
        if isCursorShowing () then
            -- Is there any gridlist?
            if #dxGrid.items > 0 then
                -- Is there any selected gridlist?
                if cursorOn then
                    -- We pressed the scroll?
                    if press and #button > 6 then
                        -- Does the gridlist requires scroll?
                        if dxGrid.items[cursorOn].r > dxGrid.items[cursorOn].mi then
                            -- Define some variables
                            local index         =   cursorOn
                            local currentValue  =   dxGrid.items[index].s
                            local newValue      =   math.max ( 1, button == "mouse_wheel_down" and currentValue + 2 or currentValue -1 )

                            -- Check if we have spent the row's limit with the new value
                            if ( ( newValue + dxGrid.items[index].mi ) > dxGrid.items[index].r ) then
                                newValue = ( dxGrid.items[index].r - dxGrid.items[index].mi ) + 1
                            end

                            -- Set the new scroll level
                            dxGrid.items[index].s = newValue;
                        end
                    elseif press and button == "mouse1" and dxGrid.items[cursorOn].mo then
                        dxGrid.items[cursorOn].se = dxGrid.items[cursorOn].mo
                    end
                end
            end
        end
    end
)

--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Useful

function __calcMaxItems ( height )
    for i = 0, 9999 do
        if ( ( ( i + 1 ) * 25 ) >= math.floor ( height ) ) then
            return ( ( ( i + 1 ) * 25 ) > math.floor ( height ) and ( i - 1 ) or i );
        end
    end
    return false;
end

function __checkParams ( methodName, pattern, ... )
    local cTable = {
        ["string"] = "s";
        ["number"] = "n";
        ["boolean"] = "b";

        ["s"] = "string";
        ["n"] = "number";
        ["b"] = "boolean"
    };

    if #pattern > table.maxn ( { ... } ) then
        local index = table.maxn ( { ... } ) == 0 and 1 or table.maxn ( { ... } ) + 1
        return false, error ( "Bad Argument @ '"..methodName.."' [Expected "..cTable[ pattern:sub ( index, index ) ].." at argument "..index..", got none]" )
    end

    for k, v in pairs ( { ... } ) do
        if cTable[ type ( v ) ] ~= pattern:sub ( k, k ) then
            return false, error ( "Bad Argument @ '"..methodName.."' [Expected "..cTable[ pattern:sub ( k, k ) ].." at argument "..k..", got "..( type ( v ) or "none" ).."]" )
        end
    end
    return true;
end

function __checkRGB ( r, g, b )
	-- Check if all parameters were passed
	if ( not r ) or ( not g ) or ( not b ) then
		return false;
	end
	
	for _, v in ipairs ( { r, g, b } ) do
		if ( type ( v ) ~= "number" ) or ( v < 0 ) or ( v > 255 ) then
			return false;
		end
	end
	
	return true;
end

function __isMouseInPosition ( x, y, w, h )
    if not isCursorShowing() then return false end

    local res   =   { guiGetScreenSize() };
    local cpos  =   { getCursorPosition() };
    local fpos  =   { res[1] * cpos[1], res[2] * cpos[2] };
    return ( fpos[1] >= x and fpos[1] <= x + w ) and ( fpos[2] >= y and fpos[2] <= y + h )
end