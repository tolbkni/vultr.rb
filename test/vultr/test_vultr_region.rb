require "vultr"
require "minitest/autorun"

describe Vultr::Region do

  let(:region) { Vultr::Region }

  it "needs to verify list region url" do
   url = region._list

   url.must_equal "https://api.vultr.com/v1/regions/list"
  end

  it "needs to verify availability region url" do
    DCID = "1234"
    url = region._availability("DCID" => "1234")

    url.must_equal "https://api.vultr.com/v1/regions/availability?DCID=#{DCID}"
  end
end