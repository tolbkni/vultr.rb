require 'test_helper'

class VultrSnapshotTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_snapshot_list_response
    r = Vultr::Snapshot.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Array, r[:result]
  end

  def test_snapshot_create_response
    # TODO
  end

  def test_snapshot_destroy_response
    # TODO
  end

  def teardown
    # Do nothing
  end
end
