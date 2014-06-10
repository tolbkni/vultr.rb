require "vultr"
require "minitest/autorun"

describe Vultr::Plan do

  let(:plan) { Vultr::Plan }

  it "needs to verify list plan url" do
    url = plan._list

    url.must_equal "https://api.vultr.com/v1/plans/list"
  end
end