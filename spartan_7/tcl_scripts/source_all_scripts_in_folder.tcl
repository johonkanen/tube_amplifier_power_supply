# Define a procedure to run Tcl scripts in a given folder
# Optionally, you can specify a script name to run only that script
proc run_tcl_scripts {folder_path {script_name ""}} {
    # Check if the folder exists
    if {![file isdirectory $folder_path]} {
        puts "Error: The folder '$folder_path' does not exist."
        return
    }

    # Get the list of all .tcl files in the folder
    set script_files [glob -nocomplain -directory $folder_path *.tcl]

    # Check if there are any .tcl files in the folder
    if {[llength $script_files] == 0} {
        puts "No .tcl scripts found in the folder '$folder_path'."
        return
    }

    # If script_name is provided, filter the list to only include that script
    if {$script_name != ""} {
        set script_path "$folder_path/$script_name"

        # Check if the specific script exists in the list
        if {[lsearch -exact $script_files $script_path] == -1} {
            puts "Error: The script '$script_name' was not found in the folder '$folder_path'."
            return
        }

        # Set script_files to contain only the specified script
        set script_files [list $script_path]
    }

    # Run the specified script or all scripts if no specific script is provided
    foreach script $script_files {
        puts "Sourcing $script..."
        source $script
        puts "Finished sourcing $script."
    }

    puts "Execution completed."
}
