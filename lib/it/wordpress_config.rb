module Operations
  module IT
    module Wordpress
      module Config
        def self.read_db_values wp_config_file_path='wp-config.php'
          lines = File.readlines wp_config_file_path

          [ find_value_of('DB_NAME', lines),
            find_value_of('DB_USER', lines),
            find_value_of('DB_PASSWORD', lines),
            find_value_of('DB_HOST', lines) ]
        end

        def self.find_value_of key, lines
          # TODO this might fail if we've got more than one hit
          line = lines.find {|l| l =~ /#{key}/}
          if line
            matches = line.match(/define\('#{key}', '(?<value>.*)'.*/)
            matches[:value]
          else
            nil
          end
        end
      end
    end
  end
end
