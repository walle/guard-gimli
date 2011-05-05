module Guard
  class Gimli
    class Refresher

      def initialize(options)
        @outputdir = options[:outputdir]
      end

      def reload(paths = [])
        UI.info "Building pdfs"
        start_at = Time.now
        result = ''
        command = @outputdir.nil? ? '' : "-o #{@outputdir}"
        result = system("gimli #{command}]")
        result
      end
    end
  end
end

