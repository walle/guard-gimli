require 'guard'
require 'guard/guard'

module Guard
  class Gimli < Guard

    autoload :Converter, 'guard/gimli/converter'

    attr_reader :converter

    def initialize(watchers = [], options = {})
      super
      @options = {
        :outputdir => nil,
        :stylesheet => nil
      }.update(options)
    end

    def start
      @converter = Converter.new(@options)
    end

    def stop
    end

    def run_on_change(paths)
      converter.reload(paths)
    end

  end
end

