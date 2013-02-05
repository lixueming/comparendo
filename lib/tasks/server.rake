require "#{Rails.root}/lib/server.rb"
include Server

namespace :server do
  SERVER_NAME = 'unicorn'
  WAIT_TIME = 0.1
  LIMIT = 5
  
  desc "Stop the application from running"
  task :stop do
    rails_env = ENV['RAILS_ENV'] || "development"
    if server_is_running?
      kill_running_server
    else
      puts('There is no server pid found')
    end
  end
  
  desc "Start the application server"
  task :start do
    unless server_is_running?
      begin
        rails_env = ENV['RAILS_ENV'] || "development"
        confff = ENV['config'] || "#{Rails.root}/config/unicorn.rb"
        bind_port = ENV['port'] || "3325"
        puts "Starting application on port #{bind_port} under #{rails_env} environment.."
        system("unicorn_rails -c #{confff} -D -E #{rails_env} -l 0.0.0.0:#{bind_port}")
      rescue => e
        puts e
      end
    else
      puts 'server running'
    end
  end

  desc 'Restart the application server'
  task :restart => [:stop, :start]

  def server_is_running?
    File.exist?(get_pid_file_path)
  end

  def get_server_pid
    File.read(get_pif_file_path).strip.to_i if server_is_running?
  end

  def get_pid_file_path
    @pid_file_path ||= "#{Rails.root}/tmp/pids/#{SERVER_NAME}.pid"
  end

  def kill_running_server
    begin
      require 'timeout'
      pid = kill_pidfile('TERM', get_pid_file_path, SERVER_NAME)
      Timeout.timeout(LIMIT.to_i){
        if pid
          while true
            Process.kill('TERM', pid)
            sleep(WAIT_TIME)
          end
        end
      }
    rescue Errno::ESRCH
      puts "Killed #{SERVER_NAME}(#{pid})"
    rescue Timeout::Error
      puts "Timeout(#{LIMIT}) killing #{SERVER_NAME}(#{pid})"
    end
  end
end