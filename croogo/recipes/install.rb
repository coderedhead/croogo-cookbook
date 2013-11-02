node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping croogo::install application #{application} as it is not an PHP app")
    next
  end

  execute 'write permission to tmp folder' do
	action :run
	user 'root'
	command "chmod 777 -R #{deploy[:deploy_to]}/current/app/tmp"
  end
  
  execute 'write permission to Config folder' do
	action :run
	user 'root'
	command "chmod 777 #{deploy[:deploy_to]}/current/app/Config"
  end
  
  template "#{deploy[:deploy_to]}/current/app/Config/database.php" do
	source "database.php.erb"
	mode 0755
	owner "www-data"
	group "www-data"
  end

  template "#{deploy[:deploy_to]}/current/app/Config/croogo.php" do
	source "croogo.php.erb"
	mode 0755
	owner "www-data"
	group "www-data"
  end

  template "#{deploy[:deploy_to]}/current/app/Config/settings.json" do
	source "settings.json.erb"
	mode 0777
	owner "www-data"
	group "www-data"
  end
  
end
