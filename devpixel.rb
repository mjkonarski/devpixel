require 'octokit'
require 'json'
require 'rubyserial'

config = JSON.parse(File.read('/home/michal/.devpixel'))

serialport = Serial.new(config['serial_port'], config['baud'])

client = Octokit::Client.new(access_token: config['token'])

config['pull_requests'].each do |pr|
	hash = client.pull_request(config['repo'], pr['id']).head.sha
	state = client.combined_status(config['repo'], hash).state
	puts "#{pr['pixel']} #{pr['id']} #{state}"
end