require 'guard'
require 'guard/guard'

module Guard
  class Gimli < Guard

    autoload :Refresher, 'guard/gimli/refresher'

    attr_reader :refresher

    def initialize(watchers = [], options = {})
      super
      @options = {
        :outputdir => nil
      }.update(options)
    end

    def start
      @refresher = Refresher.new(@options)
    end

    def stop
    end

    def run_on_change(paths)
      refresher.reload(paths)
    end

  end
end

