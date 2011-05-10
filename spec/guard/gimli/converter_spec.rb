require 'spec_helper'

describe Guard::Gimli::Converter do
  let(:paths) { %w[foo/bar.textile readme.markdown] }

  describe "#reload(paths = [])" do
    it "displays a message" do
      mock(Guard::UI).info("Building pdfs for #{paths.join(' ')}")
      mock(Guard::UI).info("foo/bar.pdf built")
      mock(Guard::UI).info("readme.pdf built")
      refresher = Guard::Gimli::Converter.new({ :outputdir => nil })
      mock(refresher).system("gimli -f foo/bar.textile -o foo") { true }
      mock(refresher).system("gimli -f readme.markdown") { true }
      refresher.reload(paths)
    end
  end

  it "should use file location as base for the call to gimli" do
    refresher = Guard::Gimli::Converter.new({ :outputdir => nil })

    path = 'foo/bar.textile'
    refresher.base_dir(path).should == 'foo'

    path = 'foo.textile'
    refresher.base_dir(path).should be_nil
  end

  it "should escape spaces in paths with \ " do
    refresher = Guard::Gimli::Converter.new({ :outputdir => nil })

    path = 'foo/bar.textile'
    refresher.escape(path).should == 'foo/bar.textile'

    path = 'foo bar/baz.textile'
    refresher.escape(path).should == 'foo\ bar/baz.textile'
  end

  it "should give the correct output dir" do
    refresher = Guard::Gimli::Converter.new({ :outputdir => nil })

    path = 'foo/bar.textile'
    refresher.outputdir(path).should == 'foo'

    refresher = Guard::Gimli::Converter.new({ :outputdir => 'build' })
    refresher.outputdir(path).should == 'foo/build'
  end

  it "should give the correct output info" do
    refresher = Guard::Gimli::Converter.new({ :outputdir => nil })

    path = 'foo.textile'
    refresher.outputinfo(path).should == 'foo.pdf'

    path = 'foo/bar.textile'
    refresher.outputinfo(path).should == 'foo/bar.pdf'

    refresher = Guard::Gimli::Converter.new({ :outputdir => 'build' })
    refresher.outputinfo(path).should == 'foo/build/bar.pdf'
  end

  it 'should give the correct stylesheet' do
    refresher = Guard::Gimli::Converter.new({ :stylesheet => nil })
    refresher.stylesheet.should be_nil

    refresher = Guard::Gimli::Converter.new({ :stylesheet => 'style.css' })
    refresher.stylesheet.should == 'style.css'

    refresher = Guard::Gimli::Converter.new({ :stylesheet => 'css/style.css' })
    refresher.stylesheet.should == 'css/style.css'

    refresher = Guard::Gimli::Converter.new({ :stylesheet => '/home/walle/gimli/style.css' })
    refresher.stylesheet.should == '/home/walle/gimli/style.css'
  end

  it "should give the correct command" do
    refresher = Guard::Gimli::Converter.new({ :outputdir => nil })

    path = 'foo/bar.textile'
    refresher.command(path).should == "gimli -f #{path} -o foo"

    style = 'style.css'
    refresher = Guard::Gimli::Converter.new({ :stylesheet => style })
    refresher.command(path).should == "gimli -f #{path} -o foo -s #{style}"

    style = 'css/style.css'
    refresher = Guard::Gimli::Converter.new({ :stylesheet => style })
    refresher.command(path).should == "gimli -f #{path} -o foo -s #{style}"

    refresher = Guard::Gimli::Converter.new({ :outputdir => 'build' })
    path = 'foo.textile'
    refresher.command(path).should == "gimli -f #{path} -o build"

    path = 'bar/foo.textile'
    refresher.command(path).should == "gimli -f #{path} -o bar/build"

    style = 'css/style.css'
    refresher = Guard::Gimli::Converter.new({ :outputdir => 'build', :stylesheet => style })
    refresher.command(path).should == "gimli -f #{path} -o bar/build -s #{style}"
  end

end

