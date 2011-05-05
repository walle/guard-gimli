module Guard
  class Gimli
    class Converter

      def initialize(options)
        @outputdir = options[:outputdir]
      end

      def reload(paths = [])
        UI.info "Building pdfs for #{paths.join(' ')}"
        start_at = Time.now
        paths.each do |path|
          system("gimli#{command(path)}")
          UI.info "Output => #{outputinfo(path)}"
        end
      end

      def command(path)
        command = " -f #{escape(path)}"
        command += outputdir(escape(path)).nil? ? '' : " -o #{outputdir(escape(path))}"
      end

      def outputdir(path)
        if @outputdir.nil?
          base_dir path
        else
          if base_dir(path).nil?
            @outputdir
          else
            File.join(base_dir(path), @outputdir)
          end
        end
      end

      def outputinfo(path)
        info = outputdir(path)
        info += '/' unless info.nil?
        info = info.to_s + "#{filename(path)}.pdf"
      end

      def filename(path)
        File.basename(path).gsub(/\..+$/, '')
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

