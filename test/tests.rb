Dir["./lib/**/*.rb"].each do |file|
  require file
end

Dir["./test/**/*.rb"].each do |file|
  require file
end