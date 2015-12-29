# -*- mode: ruby -*-
# vi: set ft=ruby :


# Plugin installation procedure from http://stackoverflow.com/a/28801317
required_plugins = %w(vagrant-triggers)

plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  #config.vm.box = "ubuntu/precise64" 	#12.04
  config.vm.box = "ubuntu/trusty64"	# 14.04

  # bail out on 'up' if we don't have ibm vars
  # http://www.markhneedham.com/blog/2010/11/24/ruby-checking-for-environment-variables-in-a-script/
  config.trigger.before :up do
    variables = %w{ibm_email ibm_pass}
    missing = variables.find_all { |v| ENV[v] == nil }
    unless missing.empty?
      STDERR.puts "ERROR: The following environment variables are missing and need to be defined to run this script: #{missing.join(', ')}."
      abort
    end
  end

  $ibm_email  = ENV['ibm_email']
  $ibm_pass   = ENV['ibm_pass']

  config.vm.provision "shell", privileged: true, :path => 'install-docker.sh'
  config.vm.provision "shell" do |s|
    s.path = 'install-bluemix-cli.sh'
    s.args = [$ibm_email, $ibm_pass]
  end
end
