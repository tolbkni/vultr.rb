require 'test/test_helper'

class VultrSnapshotTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_snapshot_list_url
    snapshot_list_url = 'https://api.vultr.com/v1/snapshot/list?api_key=' + Vultr.api_key
    assert_equal snapshot_list_url, Vultr::Snapshot._list
  end

  def test_snapshot_list_response
    r = Vultr::Snapshot.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Array, r[:result]
  end

  def test_snapshot_create_url
    snapshot_create_url = 'https://api.vultr.com/v1/snapshot/create?api_key=' + Vultr.api_key
    assert_equal snapshot_create_url, Vultr::Snapshot._create
  end

  def test_snapshot_create_response
    # TODO
  end

  def test_snapshot_destroy_url
    snapshot_destroy_url = 'https://api.vultr.com/v1/snapshot/destroy?api_key=' + Vultr.api_key
    assert_equal snapshot_destroy_url, Vultr::Snapshot._destroy
  end

  def test_snapshot_destroy_response
    # TODO
  end

  def teardown
    # Do nothing
  end
end