require 'vimrunner'
require 'vimrunner/rspec'

require 'rspec'

RSpec.configure do |config|
end

Vimrunner::RSpec.configure do |config|
  # Use a single Vim instance for the test suite. Set to false to use an
  # instance per test (slower, but can be easier to manage).
  config.reuse_server = false

  # Decide how to start a Vim instance. In this block, an instance should be
  # spawned and set up with anything project-specific.
  config.start_vim do
    vim = Vimrunner.start

    # Setup your plugin in the Vim instance
    plugin_path = File.expand_path('../..', __FILE__)
    vim.add_plugin(plugin_path, 'plugin/dependencywtf.vim')

    # The returned value is the Client available in the tests.
    vim
  end
end
