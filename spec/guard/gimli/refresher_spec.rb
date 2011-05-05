require 'spec_helper'

describe Guard::Gimli::Refresher do
  let(:paths) { %w[foo/bar.textile readme.markdown] }

  describe "#reload(paths = [])" do
    it "displays a message" do
      Guard::UI.should_receive(:info).with("Building pdfs for #{paths.join(' ')}")
      refresher = Guard::Gimli::Refresher.new({ :outputdir => nil })
      refresher.should_receive("system").with("gimli -f foo/bar.textile")
      refresher.should_receive("system").with("gimli -f readme.markdown")
      refresher.reload(paths)
    end
  end

end

