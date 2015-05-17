require 'test/test_helper'

class VultrBackupTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_backup_list_url
    backup_list_url = 'https://api.vultr.com/v1/backup/list?api_key=' + Vultr.api_key
    assert_equal backup_list_url, Vultr::Backup._list
  end

  def test_backup_list_response
    r = Vultr::Backup.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Array, r[:result]
  end

  def teardown
    # Do nothing
  end
end
