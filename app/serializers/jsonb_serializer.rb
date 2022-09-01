# frozen_string_literal: true

# JsonbSerializer
class JsonbSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    (hash || {}).with_indifferent_access
  end
end
