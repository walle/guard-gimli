require 'spec_helper'

describe Guard::Gimli::Refresher do
  let(:paths) { %w[foo/bar.textile readme.markdown] }

  describe "#reload(paths = [])" do
    it "displays a message" do
      mock(system('gimli ')) { true }
      Guard::UI.should_receive(:info).with("Building pdfs")
      Guard::Gimli::Refresher.new({ :outputdir => nil }).reload(paths)
    end
  end

end

