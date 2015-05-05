require 'yaml'

file     = File.read('browser.yml')
browsers = YAML.load(file)
pattern  = /.*\.(sqlite|db)$/

browsers.each do |browser|

  Dir.glob(Dir.home + browser['path'] + "/**/*").each {|fn|
    if pattern =~ fn
      p "optimizing #{fn}"
      `sqlite3 "#{fn}" REINDEX`
      p fn if $?.exitstatus != 0
      `sqlite3 "#{fn}" VACUUM`
      p fn if $?.exitstatus != 0
    end
  }
  
end
