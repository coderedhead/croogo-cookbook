node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping croogo::install application #{application} as it is not an PHP app")
    next
  end

  execute 'write permission to tmp folder' do
	action :run
	user 'ubuntu'
	command "chmod 777 -R #{deploy[:deploy_to]}/current/app/tmp"
  end
end
