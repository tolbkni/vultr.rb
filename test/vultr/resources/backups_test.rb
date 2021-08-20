# frozen_string_literal: true

require "test_helper"

class BackupsResourceTest < Minitest::Test
  def test_list
    stub = stub_request("backups", response: stub_response(fixture: "backups/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    backups = client.backups.list
    assert_equal Vultr::Collection, backups.class
    assert_equal Vultr::Backup, backups.data.first.class
    assert_equal 1, backups.total
  end

  def test_retrieve
    backup_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("backups/#{backup_id}", response: stub_response(fixture: "backups/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    backup = client.backups.retrieve(backup_id: backup_id)

    assert_equal Vultr::Backup, backup.class
    assert_equal "complete", backup.status
  end
end
