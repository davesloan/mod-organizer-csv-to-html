require 'csv'

## Edit only if you do not use the default locations.
CSV_FILE = 'mod_list.csv'
SMC_FILE = 'smc_list.csv'
MERGED_FILE = 'merged_list.csv'
HTML_FILE = 'mod_list.html'
##

mods = []
total_mods = 0
audio_mods = 8
utility_mods = 19
visual_mods = 90

abort 'CSV file not found!' unless File.exist?(CSV_FILE)

puts ''
puts '=== processing CSV file'

CSV.foreach(CSV_FILE, headers: true) do |row|
  mods << {
    nexus_id: row[0],
    name: row[1].gsub('&', '&amp;'),
    version: row[2]
  }
end
mods.uniq! { |mod| mod[:name] }
mods.sort_by! { |mod| mod[:name] }

open(HTML_FILE, 'w') do |f|
  count = 0
  f.puts '<h2>Activated Mods (Merged Mods Not Included)</h2>'
  f.puts '<ul>'
  mods.each do |mod|
    next if mod[:name][0] == '!'
    next if mod[:name][0..9] == 'Unmanaged:'
    next if mod[:name][0..2].downcase == 'smc'
    count += 1
    version = mod[:version][0] == 'd' ? '' : " <i>(#{mod[:version].chomp})</i>"
    if mod[:nexus_id] == '0'
      f.puts "<li>#{mod[:name].gsub('&', '&amp;')}#{version}</li>"
    else
      f.puts "<li><a href='http://www.nexusmods.com/skyrim/mods/#{mod[:nexus_id]}/?'>#{mod[:name].chomp.gsub('&', '&amp;')}</a>#{version}</li>"
    end
  end
  f.puts '</ul>'
  total_mods += count
  puts "=== #{count} activated mods added to list"

  if File.exist?(MERGED_FILE)
    categorized = []
    CSV.foreach(MERGED_FILE) do |row|
      categorized << {
        category: row[0],
        name: row[1],
        nexus_id: row[2],
        version: row[3]
      }
    end
    f.puts ''
    f.puts '<h2>Merged Mods (Merge File -- Mod Name)</h2>'
    f.puts '<ul>'
    categorized.each do |mod|
      version = mod[:version][0] == '' ? '' : " <i>(#{mod[:version].chomp})</i>"
      if mod[:nexus_id] == '0' || mod[:nexus_id] == ''
        f.puts "<li>#{mod[:category].gsub('&', '&amp;')} -- #{mod[:name].gsub('&', '&amp;')}#{version}</li>"
      else
        f.puts "<li>#{mod[:category].gsub('&', '&amp;')} -- <a href='http://www.nexusmods.com/skyrim/mods/#{mod[:nexus_id]}/?'>#{mod[:name].chomp.gsub('&', '&amp;')}</a>#{version}</li>"
      end
      visual_mods += 1 if mod[:category] == 'Visuals'
    end
    f.puts '</ul>'
    total_mods += categorized.count
    puts "=== #{categorized.count} merged mods added to list"
  end

  if File.exist?(SMC_FILE)
    count = 0
    count += 1
    f.puts ''
    f.puts '<h2>Mods Merged by Skyrim Mod Combiner</h2>'
    f.puts '<ul>'
    CSV.foreach(SMC_FILE) do |row|
      count += 1
      visual_mods += 1
      f.puts "<li>#{row[0].gsub('&', '&amp;')}</li>"
    end
    f.puts '</ul>'
    total_mods += count
    puts "=== #{count} SMC mods added to list"
  end
end
puts "=== conversion complete"
puts "=== Your list contains #{total_mods} total mods."
puts "=== Your list contains #{audio_mods} audio mods."
puts "=== Your list contains #{visual_mods} visual mods."
puts "=== Your list contains #{utility_mods} utility mods."
