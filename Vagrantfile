$script = <<SCRIPT
  cd /vagrant
  bundle
  if [ ! -f ~/vagrant-already-provisioned ]; then
    bundle exec rake db:setup
    touch ~/vagrant-already-provisioned
  else
    bundle exec rake db:migrate
  fi
SCRIPT

Vagrant.configure('2') do |config|
  config.vm.box      = 'precise64'
  config.vm.box_url  = 'http://files.vagrantup.com/precise64.box'
  config.vm.hostname = 'angularails.localhost'

  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 4096]
    v.customize ["modifyvm", :id, "--cpus", 4]
  end

  config.vm.network :private_network, ip: "192.168.33.11"   #old value is "192.168.33.10"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 5900, host: 5900

  # Provision with a shell script the things the Puppet messes up (like upgrading ruby then working with gems... yuck.)
  config.vm.provision :shell, :path => "script/provision.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.module_path    = 'puppet/modules'
  end

  # Get bundle up and running
  config.vm.provision :shell do |s|
    s.inline = $script
  end
end

