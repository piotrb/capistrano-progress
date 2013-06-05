class ParallelStatus

  def initialize(servers)
    @statuses = {}
    servers.each { |server|
      @statuses[server] = "-"
    }
  end

  def step(server, message)
    @statuses[server] = message
    Thread.exclusive do
      clear
      render
    end
  end

  def render
    table = Terminal::Table.new :headings => ["Server", "Roles", "Status"]
    @statuses.each do |server,message|
      table << [server.to_s, server.roles_string, message]
    end
    puts table
  end

  def clear
    count = @statuses.keys.length + 4
    count.times do
      print "\e[1A\e[K"
    end
  end

  def block
    render
    yield
  end

end
