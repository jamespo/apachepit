require "apache2"

cached_files = {}

-- from docs - read file into cache
function read_file(filename)
    local input = io.open(filename, "r")
    if input then
        local data = input:read("*a")
        cached_files[filename] = data
        file = cached_files[filename]
        input:close()
    end
    return cached_files[filename]
end

-- from docs - serve file from cache if possible
function check_cache(r)
   local file = cached_files[r.filename] -- Check cache entries
   if not file then
      file = read_file(r.filename)  -- Read file into cache
   end
   if file then -- If file exists, write it out
      r.status = 404
      r:write(file)
      r:info(("Sent %s to client from cache"):format(r.filename))
   end
end

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
end


-- put 404s in pit
function handle_404(r)
   addtopit(r)
   r.filename = "/opt/apachepit/html/404.html"
   rc = check_cache(r)
end
