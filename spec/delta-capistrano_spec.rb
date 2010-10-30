require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DeltaCapistrano" do
  it "should include additional features on Capistrano::Configuration" do
    Capistrano::Configuration.included_modules.should include DeltaCapistrano::Configuration::Actions::RunInShell
  end
end
