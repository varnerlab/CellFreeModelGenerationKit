# -- PRIVATE FUNCTIONS NOT EXPORTED -------------------------------------------------------------- #
function _build_copyright_header_buffer(intermediate_dictionary::Dict{String,Any})
  
    # What is the current year?
    current_year = string(Dates.year(now()))
  
    # Get comment data from
    buffer = ""
    buffer*= "# ----------------------------------------------------------------------------------- #\n"
    buffer*= "# Copyright (c) $(current_year) Varnerlab\n"
    buffer*= "# Robert Frederick Smith School of Chemical and Biomolecular Engineering\n"
    buffer*= "# Cornell University, Ithaca NY 14850\n"
    buffer*= "#\n"
    buffer*= "# Permission is hereby granted, free of charge, to any person obtaining a copy\n"
    buffer*= "# of this software and associated documentation files (the \"Software\"), to deal\n"
    buffer*= "# in the Software without restriction, including without limitation the rights\n"
    buffer*= "# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell\n"
    buffer*= "# copies of the Software, and to permit persons to whom the Software is\n"
    buffer*= "# furnished to do so, subject to the following conditions:\n"
    buffer*= "#\n"
    buffer*= "# The above copyright notice and this permission notice shall be included in\n"
    buffer*= "# all copies or substantial portions of the Software.\n"
    buffer*= "#\n"
    buffer*= "# THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\n"
    buffer*= "# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n"
    buffer*= "# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\n"
    buffer*= "# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\n"
    buffer*= "# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\n"
    buffer*= "# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN\n"
    buffer*= "# THE SOFTWARE.\n"
    buffer*= "# ----------------------------------------------------------------------------------- #\n"
  
    # return -
    return buffer  
end

# -- PUBLIC FUNCTIONS EXPORTED --------------------------------------------------------------------- #
function build_data_dictionary_program_component(intermediate_dictionary::Dict{String,Any})::VLResult

    # initialize -
    filename = "Data.jl"
    buffer = Array{String,1}()

    try 

        # build the header -
        header_buffer = _build_copyright_header_buffer(intermediate_dictionary)
        +(buffer, header_buffer)

        +(buffer,"function generate_default_data_dictionary(")
        +(buffer,"path_to_biophysical_constants_file::String = \"./src/config/Biophysics.toml\",\n");
        +(buffer,"\tpath_to_ec_file::String = \"./src/config/EC.toml\",\n\tpath_to_control_constants_file::String=\"./src/config/Control.toml\",\n");
        +(buffer,"\tbiophysical_constants_file_parser::Function=build_biophysical_dictionary,\n\tec_constants_file_parser::Function=build_ec_data_dictionary,\n\tcontrol_constants_parser::Function=build_control_constants_dictionary,\n\tvargs...)")
        +(buffer,"::Dict{String,Any}\n")
        +(buffer,"\n")
        +(buffer,"\t# initialize - \n")
        +(buffer,"\tdata_dictionary = Dict{String,Any}()\n")
        +(buffer,"\treturn data_dictionary\n")
        +(buffer,"end\n")

        # collapse -
        flat_buffer = ""
        [flat_buffer *= line for line in buffer]
        
        # package up into a NamedTuple -
        program_component = (buffer=flat_buffer, filename=filename, component_type=:buffer)

        # return -
        return VLResult(program_component)

    catch error
        return VLResult(error)
    end
end

# function to build Control.jl 
function build_control_program_component(intermediate_dictionary::Dict{String,Any})::VLResult

    # initialize -
    filename = "Control.jl"
    buffer = Array{String,1}()

    try

        # build the header -
        header_buffer = _build_copyright_header_buffer(intermediate_dictionary)
        +(buffer, header_buffer)
        +(buffer, "\n")

        # TODO: Control logic goes here ...

        # collapse -
        flat_buffer = ""
        [flat_buffer *= line for line in buffer]
        
        # package up into a NamedTuple -
        program_component = (buffer=flat_buffer, filename=filename, component_type=:buffer)

        # return -
        return VLResult(program_component)

    catch error
        return VLResult(error)
    end
end

# function to build Kinetics.jl
function build_kinetics_program_component(intermediate_dictionary::Dict{String,Any})::VLResult

    # initialize -
    filename = "Kinetics.jl"
    buffer = Array{String,1}()

    try 

        # build the header -
        header_buffer = _build_copyright_header_buffer(intermediate_dictionary)
        +(buffer, header_buffer)
        +(buffer, "\n")

        # TODO: Kinetics logic goes here ...

        # collapse -
        flat_buffer = ""
        [flat_buffer *= line for line in buffer]
        
        # package up into a NamedTuple -
        program_component = (buffer=flat_buffer, filename=filename, component_type=:buffer)

        # return -
        return VLResult(program_component)
    catch error
        return VLResult(error)
    end
end
# --------------------------------------------------------------------------------------------------- #