
module DeltaCapistrano
  module Configuration
    module Actions
      
      module RunInShell

        def in_a_shell_as(user, cmd = "")
          command_array = array_of_commands
          
          command_array << cmd
          
          yield command_array  if block_given?

          sudo "sh -c '#{command_array.joined_by_semi_colon}'", :as => user
        end

        private

        def array_of_commands
          a = []
          
          def a.run(command_string)
            self <<  command_string
          end

          def a.joined_by_semi_colon
            reject {|s| s.nil? || s == ""  }.join("; ")
          end
          
          return a
        end

      end
      
    end
  end
end
