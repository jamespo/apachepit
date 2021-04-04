-- checkpit: check if IP is in pit, return 401 if so
function checkpit(r)
   -- check if ip is in badhits table, return forbidden if so
   local retcode = apache2.OK
   db = r:dbacquire()
   if not err then
      -- check if IP is in badhit
      local statement, err = db:prepared(r, "checkpitsql")
      -- r:err("error " .. err)
      if not err then
	 local results, err = statement:select(r.useragent_ip)
	 -- local results, err = database:select(r, "SELECT `ip` FROM `badhit` WHERE `ip` = '127.0.0.1'")
	 if not err then
	    local row = results(-1) -- get one row
	    k, v = pairs(row)
	    if v ~= nil then
	       -- match found, return unauthorized
	       retcode = 401
	    end
	 end
      end
   end
   -- db:close()
   return retcode
end



function addtopit(r)
end
