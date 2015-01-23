require 'spec_helper_acceptance'

#####################################################################################################
#
# Name: helper_functions.rb
#
# Purpose: Defines functions that are used by spec tests to do things like install modules
#          and read test manifests
#
#####################################################################################################

def get_module_directory (course_name, module_name, lesson_name='')
  # Construct the full path to the courseware/fundamentals/_files directory on the host.
  course_root_dir = File.expand_path(File.join(File.dirname(__FILE__), "../#{course_name}"))
 
  # Construct the full path on the host to the module we want to test by appending
  # module_name to the path constructed above
  # e.g. /path/to/courseware/fundamentals/_files/users
  #
  # If a lesson name was specified, then prepend that to the root dir.
  # This is to distinguish between the various apache modules.
  if lesson_name
    module_dir = "#{course_root_dir}/_files/#{lesson_name}/#{module_name}"
  else
    module_dir = "#{course_root_dir}/_files/#{module_name}"
  end

  return module_dir
end

def install_solution_module (course_name, module_name, lesson_name = '')
  # Get the path to the module we want to test
  module_dir = get_module_directory(course_name, module_name, lesson_name)

  # Use puppet_module_install to scp the module directory from the host into the modulepath on the target VM
  # NOTE: puppet_module_install is defined in beaker-rspec: 
  #       https://github.com/puppetlabs/beaker-rspec/blob/master/lib/beaker-rspec/beaker_shim.rb
  puppet_module_install(:source => module_dir, :module_name => module_name)
end

def read_solution_manifest(course_name, module_name, test_name, lesson_name='')
  # Get the path to the module we want to test
  module_dir = get_module_directory(course_name, module_name, lesson_name)

  # build the path to the solution test manifest.
  module_test = "#{module_dir}/tests/#{test_name}"

  # Read the test manifest and return its contents
  solution_manifest = File.open(module_test).read

  return solution_manifest
end
