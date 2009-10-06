def use_database(env)
  db = File.dirname(__FILE__) + "/../config/database.yml"
  config = YAML.load(ERB.new(IO.read(db)).result)
  (config[env]).symbolize_keys
end
