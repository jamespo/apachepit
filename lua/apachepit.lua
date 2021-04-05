-- checkpit: check if IP is in pit, return 401 if so
function checkpit(r)
   local retcode = apache2.OK
   db = r:dbacquire()  -- configured in mod_dbd in Apache
   local statement, err = db:prepared(r, "checkpitsql")
   if not err then
      local results, err = statement:select(r.useragent_ip)
      if not err then
	 local row = results(-1) -- get one row
	 k, v = pairs(row)
	 if v ~= nil then
	    -- match found, return unauthorized
	    retcode = 401
	 end
      end
   end
   return retcode
end


-- addtopit: add ip to pit
function addtopit(r)
   db = r:dbacquire()  -- configured in mod_dbd in Apache
   local statement, err = db:prepared(r, "addpitsql")
   if not err then
      local results, err = statement:query(r.useragent_ip)
   end
   return 404
end
