require 'yaml'

class Hat
  attr_accessor :name, :size, :id
  @@IDS_PATH = '/tmp/hat_app/ids.yml'
  @@HATS_PATH= '/tmp/hat_app/hats.yml'

  def self.all
    Hat.load_hats
    Hat.load
    @@hats
  end

  def initialize hash = nil
    if hash != nil then
      @name = hash[:name]
      @size = hash[:size]
      @id = nil
    else
      @name = @size = @id = nil
    end
  end

  def self.find_by_id id
    @@hats.find { |hat| id.to_i === hat.id } 
  end

  def save
    @id ||= @@max_id + 1
    @@max_id += 1
    @@hats << self
    Hat.dump 
    Hat.dump_hats
  end

  # Freebie
  def self.nuke
    @@max_id = 0
    @@hats = []
    Hat.dump
    Hat.dump_hats
  end

  def self.dump
    File.open(@@IDS_PATH, 'w') do |file|
      file.write(YAML.dump(@@max_id))
    end 
  end

  def self.load
    if File.exists? @@IDS_PATH then
      YAML.load_file @@IDS_PATH or 0 
    else
      0
    end
  end

  def self.load_hats
    if File.exists? @@HATS_PATH then
      YAML.load_file @@HATS_PATH or [] 
    else
      []
    end
  end

  def self.dump_hats
    File.open(@@HATS_PATH, 'w') do |file|
      file.write(YAML.dump(@@hats))
    end
  end

  def self.create hash
    hat = Hat.new hash
    hat.save
    hat
  end

  def self.find_by_name name
    @@hats.select { |hat| name === hat.name }
  end

  def update hash
    save
    @name = hash[:name] if hash[:name] != nil
    @size = hash[:size] if hash[:size] != nil
    Hat.dump_hats 
  end

  def self.delete id
    hat = Hat.find_by_id(id)
    hat = nil
    @@hats = @@hats.select {|h| h.id != id}
    Hat.dump
    Hat.dump_hats 
  end

  @@max_id = self.load
  @@hats = self.load_hats
end
