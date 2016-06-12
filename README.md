# Mod Organizer CSV-to-HTML Conversion Script (For Skyrim)

This script is written in Ruby. You must have Ruby installed on your computer before you can use the script. To use:
 * If you have merged any mods into single esp files and imported them into Mod Organizer, add an exclamation point to the front of the name. It will not be included in the list of activated mods.
 * If you have imported a package created by Skyrim Mod Combiner, add SMC to the front of the name. It will not be included in the list of activated mods.
 * Export your mod list in Mod Organizer to a CSV file and save it as ```mod_list.csv``` in the same folder as the script. (this does not need to be sorted or modified in any way)
 * Create a CSV file of all your merged mods. The first column of the row should be the name of the merged mod and the second row should be the name of the mod that was included in the merge. You must sort these yourself as the script will not sort them for you. Save it as ```merged_list.csv``` in the same directory as the script. (this is optional if you don't merge mods)
 * Create a CSV file of all the mods you included when you used Skyrim Mod Combiner. This should simply be one mod name per row. This should be sorted by you as they will not be sorted by the script. Save it as ```smc_list.csv``` in the same directory as the script. (this is optional if you don't use Skyrim Mod Organizer)
 * run ```ruby convert.rb``` from the command line and the script should generate a file called ```mod_list.html```.

Examples of all the CSV files have been included. Please overwrite them with your own data.
