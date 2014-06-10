require "vultr"
require "minitest/autorun"

describe Vultr::OS do

  let(:os) { Vultr::OS }

  it "needs to verify list os url" do
    url = os._list

    url.must_equal "https://api.vultr.com/v1/os/list"
  end
end
