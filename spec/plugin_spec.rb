require 'spec_helper'

describe 'vim-dependencywtf' do
  before do
    # Just echo the URL that would be opened instead of opening it
    vim.command("let g:dependencywtf_testing='true'")
  end

  # Get the absolute path to a specified fixture file
  #
  # name - Filename, in the examples directory, for which to get the path
  #
  # Example
  #
  #   fixture('Gemfile')
  #   # => /Users/tsigo/Code/vim/vim-dependencywtf/spec/fixtures/Gemfile
  def fixture(name)
    File.expand_path("../fixtures/#{name}", __FILE__)
  end

  # Go to a specific line in the file
  def line(num)
    vim.command(num)
  end

  # Run the main `DependencyWTF()` plugin command
  def wtf
    vim.command('DependencyWTF')
  end

  context 'in a Gemfile' do
    before do
      vim.edit fixture('Gemfile')
    end

    it 'matches a gem with a version string' do
      line 11
      wtf.should eq 'https://rubygems.org/gems/rails'
    end

    it 'matches a simple gem in double quotes' do
      line 13
      wtf.should eq 'https://rubygems.org/gems/protected_attributes'
    end

    it 'matches a simple gem in single quotes' do
      line 14
      wtf.should eq 'https://rubygems.org/gems/rails-observers'
    end

    it 'matches a gem with a group' do
      line 22
      wtf.should eq 'https://rubygems.org/gems/mysql2'
    end

    it 'matches a gem with a require' do
      line 41
      wtf.should eq 'https://rubygems.org/gems/gitlab_omniauth-ldap'
    end

    it 'matches a gem with a git repository' do
      line 52
      wtf.should eq 'https://rubygems.org/gems/grape-entity'
    end
  end

  context 'in a .gemspec file' do
    before do
      vim.edit fixture('kaminari.gemspec')
    end

    it 'matches a simple dependency in single quotes' do
      line 24
      wtf.should eq 'https://rubygems.org/gems/activesupport'
    end

    it 'matches a simple dependency in double quotes' do
      line 25
      wtf.should eq 'https://rubygems.org/gems/actionpack'
    end

    it 'matches a development dependency in single quotes' do
      line 27
      wtf.should eq 'https://rubygems.org/gems/bundler'
    end

    it 'matches a development dependency in double quotes' do
      line 28
      wtf.should eq 'https://rubygems.org/gems/rake'
    end
  end

  context 'in a Vundle file' do
    before do
      vim.edit fixture('vimrc.bundles')
    end

    it 'matches a GitHub-style Bundle in single quotes' do
      line 1
      wtf.should eq 'https://github.com/tpope/vim-rails.git'
    end

    it 'matches a GitHub-style Bundle in double quotes with extra arguments' do
      line 2
      wtf.should eq 'https://github.com/rstacruz/sparkup'
    end

    it 'matches a GitHub-style Plugin in single quotes' do
      line 6
      wtf.should eq 'https://github.com/tpope/vim-rails.git'
    end

    it 'matches a Vimscripts-style Bundle' do
      line 8
      wtf.should eq 'https://github.com/vim-scripts/L9'
    end

    it 'matches GitHub-style Plug in single quotes' do
      line 11
      expect(wtf).to eq 'https://github.com/tpope/vim-rails.git'
    end
  end
end
