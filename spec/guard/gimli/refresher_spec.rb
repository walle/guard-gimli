require 'spec_helper'

describe Guard::Gimli::Refresher do
  let(:paths) { %w[foo/bar.textile readme.markdown] }

  describe "#reload(paths = [])" do
    it "displays a message" do
      mock(Guard::UI).info("Building pdfs for #{paths.join(' ')}")
      refresher = Guard::Gimli::Refresher.new({ :outputdir => nil })
      mock(refresher).system("gimli -f foo/bar.textile") { true }
      mock(refresher).system("gimli -f readme.markdown") { true }
      refresher.reload(paths)
    end

    it "should use file location as base for the call to gimli" do
      refresher = Guard::Gimli::Refresher.new({ :outputdir => nil })

      path = 'foo/bar.textile'
      refresher.base_dir(path).should == 'foo'

      path = 'foo.textile'
      refresher.base_dir(path).should == '.'
    end
  end

end

