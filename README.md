# VersionLocker

Lock gems in Gemfile at a specific version based on what is loaded, independent of Gemfile.lock

## Installation

Add this line to your application's Gemfile:

    gem 'version_locker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install version_locker

## Usage
Valid options are gemfile_path, spermy, and target (IO object to write to)

VersionLocker.lock!(options)
