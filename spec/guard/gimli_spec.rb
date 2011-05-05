require 'spec_helper'

describe Guard::Gimli do
  subject { Guard::Gimli.new }

  describe "#initialize" do
    describe ":outputdir" do
      it "is nil by default" do
        subject = Guard::Gimli.new([])
        subject.options[:outputdir].should be_nil
      end

      it "can be set " do
        subject = Guard::Gimli.new([], { :outputdir => 'build' })
        subject.options[:outputdir].should == 'build'
      end
    end
  end

  describe "#start" do
    it "creates refresher with default options" do
      subject = Guard::Gimli.new([])
      Guard::Gimli::Refresher.should_receive(:new).with(:outputdir => nil)
      subject.start
    end

    it "creates reactor with given options" do
      subject = Guard::Gimli.new([], { :outputdir => 'build' })
      Guard::Gimli::Refresher.should_receive(:new).with(:outputdir => 'build')
      subject.start
    end
  end

  describe "#run_on_change" do
    it "converts pdfs" do
      refresher = mock(Guard::Gimli::Refresher)
      subject.stub(:refresher).and_return(refresher)
      refresher.should_receive(:reload).with(['foo'])
      subject.run_on_change(['foo'])
    end
  end
end

