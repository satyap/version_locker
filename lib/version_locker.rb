require "version_locker/version"
require "version_locker/locker"

module VersionLocker
  def self.lock!(options = {})
    Locker.new(options).lock!
  end
end
