#
# load config file
#

require 'yaml'

module SRAS
    module Config
        if ENV['SRAS_CONFIG_FILE']
            config_file = ENV['SRAS_CONFIG_FILE']
        elsif File.exist?("../config/config.yml")
            config_file = "../config/config.yml"
        elsif File.exist?(File.expand_path('~/.srasrc'))
            config_file = File.expand_path('~/.srasrc')
        elsif File.exist?('/etc/sras/sras.conf')
            config_file = '/etc/sras/sras.conf'
        else
            raise "Couldn't find SRAS config file"
        end

        @config = YAML.load_file(config_file)

        def self.host
            if ENV['SRAS_BIND_HOST']
                ENV['SRAS_BIND_HOST']
            elsif @config['sras']['production']['host']
                @config['sras']['production']['host']
            else
                '0.0.0.0'
            end
        end

        def self.socket_file
            if ENV['SRAS_SOCKET_FILE']
                ENV['SRAS_SOCKET_FILE']
            elsif @config['sras']['production']['socket_file']
                @config['sras']['production']['socket_file']
            end
        end

        def self.port
            if ENV['SRAS_BIND_PORT']
                ENV['SRAS_BIND_PORT']
            elsif @config['sras']['production']['port']
                @config['sras']['production']['port']
            else
                '8003'
            end
        end

        def self.default_asset_dir
            if @config['sras']['production']['default_asset_dir']
                @config['sras']['production']['default_asset_dir']
            else
                '/srv/sras'
            end
        end

        def self.log_file
            if ENV['SRAS_LOG_FILE']
                ENV['SRAS_LOG_FILE']
            elsif @config['sras']['production']['log_file']
                @config['sras']['production']['log_file']
            else
                'log/sras.log'
            end
        end

        def self.pid_file
            if ENV['SRAS_PID_FILE']
                ENV['SRAS_PID_FILE']
            elsif @config['sras']['production']['pid_file']
                @config['sras']['production']['pid_file']
            else
                '/tmp/sras.pid'
            end
        end

        def self.db_host
            if @config['mysql']['production']['host']
                @config['mysql']['production']['host']
            else
                'localhost'
            end
        end

        def self.database
            @config['mysql']['production']['database']
        end

        def self.username
            @config['mysql']['production']['username']
        end

        def self.password
            @config['mysql']['production']['password']
        end
    end
end
