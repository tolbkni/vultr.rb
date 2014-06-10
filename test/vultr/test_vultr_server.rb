require "vultr"
require "minitest/autorun"

describe Vultr::Server do

  let(:server) { Vultr::Server }

  it "needs to verify list server url" do
    url = server._list

    url.must_equal "https://api.vultr.com/v1/server/list?api_key=api_key_required"
  end

  it "needs to verify reboot server url" do
    url = server._reboot

    url.must_equal "https://api.vultr.com/v1/server/reboot?api_key=api_key_required"
  end

  it "needs to verify halt server url" do
    url = server._halt

    url.must_equal "https://api.vultr.com/v1/server/halt?api_key=api_key_required"
  end

  it "needs to verify start server url" do
    url = server._start

    url.must_equal "https://api.vultr.com/v1/server/start?api_key=api_key_required"
  end

  it "needs to verify destroy server url" do
    url = server._destroy

    url.must_equal "https://api.vultr.com/v1/server/destroy?api_key=api_key_required"
  end

  it "needs to verify create server url" do
    url = server._create

    url.must_equal "https://api.vultr.com/v1/server/create?api_key=api_key_required"
  end
end