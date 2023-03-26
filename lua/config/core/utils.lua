local M = {}

function M.withTable(first_table, second_table)
   local withTable = {}
   M.concatTable(withTable, first_table)
   M.concatTable(withTable, second_table)
   return withTable
end

function M.concatTable(first_table, second_table)
	for k, v in pairs(second_table) do
		first_table[k] = v
	end
end

function M.printTable( t )

    local printTable_cache = {}

    ---@diagnostic disable-next-line (for some reason the t is redefined, and I can't fix it, yet. -MW2: )
    local function sub_printTable( t, indent )

        if ( printTable_cache[tostring(t)] ) then
            print( indent .. "*" .. tostring(t) )
        else
            printTable_cache[tostring(t)] = true
            if ( type( t ) == "table" ) then
                for pos,val in pairs( t ) do
                    if ( type(val) == "table" ) then
                        print( indent .. "[" .. pos .. "] => " .. tostring( t ).. " {" )
                        sub_printTable( val, indent .. string.rep( " ", string.len(pos)+8 ) )
                        print( indent .. string.rep( " ", string.len(pos)+6 ) .. "}" )
                    elseif ( type(val) == "string" ) then
                        print( indent .. "[" .. pos .. '] => "' .. val .. '"' )
                    else
                        print( indent .. "[" .. pos .. "] => " .. tostring(val) )
                    end
                end
            else
                print( indent..tostring(t) )
            end
        end
    end

    if ( type(t) == "table" ) then
        print( tostring(t) .. " {" )
        sub_printTable( t, "  " )
        print( "}" )
    else
        sub_printTable( t, "  " )
    end
end


function M.loadModule(moduleName)
	local status_ok, module = pcall(require, moduleName)
	if not status_ok then
		print(debug.getinfo(2, "S").source .. ": require " .. moduleName .. " failed.")
		return
	end

	return module
end

return M
