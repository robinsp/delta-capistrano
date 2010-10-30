require 'capistrano'
require 'delta_capistrano/configuration/actions/run_in_shell'

module Capistrano
  class Configuration
    include DeltaCapistrano::Configuration::Actions::RunInShell
  end
end
