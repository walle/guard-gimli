module Guard
  class Gimli
    class Refresher

      def initialize(options)
        @outputdir = options[:outputdir]
      end

      def reload(paths = [])
        UI.info "Building pdfs for #{paths.join(' ')}"
        start_at = Time.now
        paths.each do |path|
          escaped_path = escape path
          command = " -f #{escaped_path}"
          command += @outputdir.nil? ? '' : " -o #{outputdir}"
          system("gimli#{command}")
        end
      end

      def outputdir(path)
        if @outputdir.nil?
          base_dir path
        else
          File.join base_dir(path), @outputdir
        end
      end

      def base_dir(path)
        dir = File.dirname path
        dir unless dir == '.'
      end

      def escape(path)
        path.gsub(' ', '\ ')
      end
    end
  end
end

