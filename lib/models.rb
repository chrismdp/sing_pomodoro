@appenv ||= 'development'

def use_main_app_database
  db = File.dirname(__FILE__) + "/../config/database.yml"
  config = YAML.load(ERB.new(IO.read(db)).result)
  (config[@appenv]).symbolize_keys
end

ActiveRecord::Base.establish_connection(use_main_app_database)
