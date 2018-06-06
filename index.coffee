fs = require 'fs'


exports.countryIpCounter = (countryCode, cb) ->
  return cb() unless countryCode

  readStream = fs.createReadStream "#{__dirname}/../data/geo.txt"
  counter = 0
  remaining = ''
  readStream.on("data", (data) -> 
    data = remaining + data
    data = data.toString().split '\n'
    for line in data when line
      line = line.split '\t'
      if line.length < 5 then remaining = line.join '\t'
      else 
        remaining = ''
        if line[3] == countryCode then counter += +line[1] - +line[0]
  )
  readStream.on("end", () -> 
    cb null, counter 
  )
