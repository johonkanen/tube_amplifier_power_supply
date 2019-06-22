#This script copies .xci files from the IP directory into unique 
#subfolders within the BuildFiles directory.
#The directory structure is assumed to be

# Root
#   - Constraints
#    - RTL 
#    - Sim
#    - TclScripts
#    - IP
#        - *.xci
#    - BuildFiles #Not stored in source control
#
#This script must be run from the TclScrips directory

#Check if BuildFiles has already been created
if { [file isdirectory ../BuildFiles]  > 0} {
    #BuildFiles has already been created. Do nothing
    return
} else {
    #Create BuildFiles
    file mkdir ../BuildFiles
}

#Check IP directory for .xci files to copy
set xciFiles [glob -nocomplain "../IP/*.xci"]
if {[llength $xciFiles] < 1} {
    #There are no .xci files. Exit script
    return
} else {
    #There are .xci files. Create subfolders within BuildFiles and copy .xci files

    #For each xci file, create a subdirectory in the BuildFiles directory
    foreach {name} $xciFiles {

        #get the name of the file plus extension
        set fileWithExtension [file tail $name]

        #get just the xciName without extension and create subfolder
        set xciName [file rootname $fileWithExtension]
        set targetPath ../BuildFiles/$xciName
        puts "creating sub-directory $targetPath"
        file mkdir $targetPath

        #copy .xci file from IP folder to newly created subdirectory
        file copy $name $targetPath
    }
}

