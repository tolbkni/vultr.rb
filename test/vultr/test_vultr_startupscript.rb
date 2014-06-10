require "vultr"
require "minitest/autorun"

describe Vultr::StartupScript do

  let(:startupscript) { Vultr::StartupScript }

  it "needs to verify list snapshot url" do
    url = startupscript._list

    url.must_equal "https://api.vultr.com/v1/startupscript/list?api_key=api_key_required"
  end

  it "needs to verify destroy snapshot url" do
    url = startupscript._destroy

    url.must_equal "https://api.vultr.com/v1/startupscript/destroy?api_key=api_key_required"
  end

  it "needs to verify create snapshot url" do
    url = startupscript._create

    url.must_equal "https://api.vultr.com/v1/startupscript/create?api_key=api_key_required"
  end
end