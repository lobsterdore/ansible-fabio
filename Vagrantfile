required_plugins = %w( vagrant-docker-compose )
required_plugins.each do |plugin|
  exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: ["/vagrant/docker-compose.yml"], run: "always"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.tags = [
      'build',
      'configure',
      'test'
    ]
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    # change the network card hardware for better performance
    v.customize ["modifyvm", :id, "--nictype1", "virtio" ]
    v.customize ["modifyvm", :id, "--nictype2", "virtio" ]
  end

end
