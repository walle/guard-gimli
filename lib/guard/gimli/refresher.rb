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
          command += @outputdir.nil? ? '' : " -o #{@outputdir}"
          system("gimli#{command}")
        end
      end

      def base_dir(path)
        File.dirname path
      end

      def escape(path)
        path.gsub(' ', '\ ')
      end
    end
  end
end

