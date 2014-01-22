module VersionLocker
  class Locker
    attr_reader :options
    GEM_PATTERN = /^(?<indentation> *)gem +['"](?<name>.+?)['"](, ['"](?<version>(~> *)?[\d\.]+)['"])?(?<options>, [^$#]+)?.*$/

    def initialize(options = {})
      @options = options
    end

    def spermy?
      options.fetch(:spermy) { true }
    end

    def gemfile_path
      options.fetch(:gemfile_path) { 'Gemfile' }
    end

    def lock!
      new_content = new_gemfile
      with_target do |target|
        target.write new_content
      end
    end

    private

    def with_target
      if options[:target]
        yield options[:target]
      else
        File.open(gemfile_path, 'w'){|f| yield f}
      end
    end

    def old_gemfile_lines
      source_text = options.fetch(:source) { File.read(gemfile_path) }
      source_text.lines
    end

    def new_gemfile
      old_gemfile_lines.map {|line| new_gemfile_line(line) }.join
    end

    def new_gemfile_line(line)
      if match = GEM_PATTERN.match(line) and valid_options?(match[:options]) and version = gem_version(match)
        lock_line(match, version)
      else
        line
      end
    end

    def valid_options?(options)
      options !~ /git|path/
    end

    def gem_version(match)
      return unless spec = Gem.loaded_specs[match[:name]]
      spec.version
    end

    def lock_line(match, version)
      line = "#{match[:indentation]} gem \"#{match[:name]}\", \"#{'~>' if spermy?}#{version}\"#{match[:options]}\n"
    end
  end
end


