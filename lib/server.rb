module Server
  
  def read_pid pid_path
    if File.exist?(pid_path)
      File.read(pid_path).strip.to_i

    else
      puts "WARN: No pid file found in #{pid_path}"
      nil

    end
  end  
  
  def kill_pidfile signal, pid_path, name = nil
    if pid = read_pid(pid_path)
      kill_raise(signal, pid, name)
      return pid
    end
    nil
  rescue Errno::ESRCH
    puts "WARN: No such pid: #{pid}, removing #{pid_path}..."
    File.delete(pid_path)
    nil
  end

  def kill_pid signal, pid, name = nil
    kill_raise(signal, pid, name)
    pid
  rescue Errno::ESRCH
    puts "WARN: No such pid: #{pid}"
    nil
  end

  def kill_raise signal, pid, name = nil
    puts "Sending #{signal} to #{name}(#{pid})..."
    Process.kill(signal, pid)
    pid
  end 
end
