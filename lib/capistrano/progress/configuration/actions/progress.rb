module Capistrano::Progress
  module Configuration
    module Actions
      module Progress

        def run_with_progress(command)
          servers = find_servers_for_task(current_task).map { |server|
            ServerWithRoles.new(server, role_names_for_host(server))
          }
          status = ParallelStatus.new(servers)
          logger_level(Capistrano::Logger::IMPORTANT) do
            status.block do
              parallelize do |session|
                servers.each do |server|
                  session.run do
                    status.step server, "Executing ..."
                    run command, :hosts => server
                    status.step server, "Done"
                  end
                end
              end
            end
          end
        end

        private

        def logger_level(level)
          old_level = logger.level
          begin
            logger.level = level
            yield
          ensure
            logger.level = old_level
          end
        end

      end
    end
  end
end

