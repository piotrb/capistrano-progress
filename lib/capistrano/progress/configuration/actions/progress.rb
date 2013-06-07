module Capistrano
  module Progress
    module Configuration
      module Actions
        module Progress

          def run_without_progress(cmd, options = {}, &block)
            if options[:eof].nil? && !cmd.include?(sudo)
              options = options.merge(:eof => !block_given?)
            end
            block ||= self.class.default_io_proc
            tree = Command::Tree.new(self) do |t| t.else(cmd, &block) end
            run_tree(tree, options)
          end

          def run(cmd, options = {}, &block)
            if @run_with_progress
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
                        run_without_progress cmd, options.merge(:hosts => server), &block
                        status.step server, "Done"
                      end
                    end
                  end
                end
              end
            else
              run_without_progress cmd, options, &block
            end
          end

          def enable_run_progress
            @run_with_progress = true
          end

          def disable_run_progress
            @run_with_progress = false
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
end

