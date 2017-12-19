module AppiumDriver
  module AppiumServer
    def start_appium_server
      cmd = "cd $APPIUM_HOME ; node . --port #{@appium_port} -U emulator-#{@avd_name}"

      puts cmd
      pid = spawn(cmd, out: '/dev/null')
      Process.detach(pid)

      50.times do
        port_open?('0.0.0.0', @port) ? break : sleep(2)
      end
    end

    def start_appium_server_with_avd
      cmd = "cd $APPIUM_HOME ; node . --port #{@appium_port} --avd-args='-port #{@avd_port}' --avd='#{@avd_name}'"

      puts cmd
      pid = spawn(cmd, out: '/dev/null')
      Process.detach(pid)

      sleep(10)
    end

    def kill_appium_server
      kill_process_at_port(@port)
    end
  end
end
