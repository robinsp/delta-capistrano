require 'spec_helper'

describe DeltaCapistrano::Configuration::Actions::RunInShell do

  let(:config) do
    Class.new { include DeltaCapistrano::Configuration::Actions::RunInShell }.new
  end
  
  it "should sudo to the supplied user" do
    user = "the_user" 
    config.should_receive(:sudo).with do |cmd, sudo_conf|
      sudo_conf.should == {:as => user}
    end
    
    config.in_a_shell_as(user)
  end

  it "should exec command in a new shell" do
    expected_command = "a command"
    
    config.should_receive(:sudo).with do |cmd, sudo_conf|
      cmd.should == "sh -c '#{expected_command}'"
    end

    config.in_a_shell_as("user", expected_command)
  end


  describe "" do

    before do
      @cmd = nil
      
      config.stub(:sudo).with do |cmd, sudo_conf|
        @cmd = cmd.scan(/sh -c '([^"]*)'/).flatten.first
      end
    end
    
    example "executes command given as argument" do
      config.in_a_shell_as("u", "from argument")
      @cmd.should == "from argument"
    end
  
    example "executes command from block" do
      config.in_a_shell_as("u") do |shell|
        shell.run "from block"
      end

      @cmd.should == "from block"
    end

    example" executes several commands from block" do
     config.in_a_shell_as("u") do |shell|
        shell.run "from block once"
        shell.run "from block twice"
      end

      @cmd.should == "from block once; from block twice"
    end

    example "executes command from argument before commands in block" do
      config.in_a_shell_as("u", "from argument") do |shell|
        shell.run "from block once"
        shell.run "from block twice"
      end

      @cmd.should == "from argument; from block once; from block twice"
    end
    
  end
  
end
