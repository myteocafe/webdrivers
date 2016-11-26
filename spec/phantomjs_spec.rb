require "spec_helper"

describe Webdrivers::PhantomJS do

  let(:phantomjs) { Webdrivers::PhantomJS }

  it 'downloads' do
    phantomjs.download
    file = "#{ENV['GEM_HOME']}/bin/phantomjs"
    expect(File.exist?(file)).to eq true
  end

  it { expect(phantomjs.newest_version.to_f).to be >= 0.11 }

  it { expect(phantomjs.downloads.size).to be >= 5 }

  context "on a linux platform" do
    before { allow(phantomjs).to receive(:platform) { "linux32" } }

    it { expect(phantomjs.file_name).to match(/phantomjs$/) }

    it { expect(phantomjs.binary_path).to match '.webdrivers/linux32/phantomjs' }

    it { expect(phantomjs.download_url('1.9.6')).to match("phantomjs-1.9.6-linux-") }
  end

  context "on a windows platform" do
    before { allow(phantomjs).to receive(:platform) { "win" } }

    it { expect(phantomjs.file_name).to match(/phantomjs\.exe$/) }

    it { expect(phantomjs.binary_path).to match '.webdrivers/win/phantomjs' }

    it { expect(phantomjs.download_url('1.9.7')).to match("phantomjs-1.9.7-windows.zip") }
  end
end
