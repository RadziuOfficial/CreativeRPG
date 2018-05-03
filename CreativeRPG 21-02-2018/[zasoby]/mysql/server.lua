local mysql = false
function polacz()
	mysql = dbConnect("mysql", "dbname=DBNAME;host=HOST", "DBNAME", "PASSWORD", "share=1")
	if not mysql then
		outputDebugString("Nieudalo polaczyc sie z baza danych.")
	else
		outputDebugString("Udalo polaczyc sie z baza danych.")
	end
end
addEventHandler("onResourceStart", resourceRoot, polacz)

function wykonaj(...)
	local qh = dbQuery(mysql, ...)
	if not qh then return false end
	local result, num_affected_rows, last_insert_id = dbPoll(qh, -1)
	return result, num_affected_rows, last_insert_id
end