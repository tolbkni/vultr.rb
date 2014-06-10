require "vultr"
require "minitest/autorun"

describe Vultr::Snapshot do

  let(:snapshot) { Vultr::Snapshot }

  it "needs to verify list snapshot url" do
    url = snapshot._list

    url.must_equal "https://api.vultr.com/v1/snapshot/list?api_key=api_key_required"
  end

  it "needs to verify destroy snapshot url" do
    url = snapshot._destroy

    url.must_equal "https://api.vultr.com/v1/snapshot/destroy?api_key=api_key_required"
  end

  it "needs to verify create snapshot url" do
    url = snapshot._create

    url.must_equal "https://api.vultr.com/v1/snapshot/create?api_key=api_key_required"
  end
end