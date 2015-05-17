require 'test/test_helper'

class VultrSshkeyTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_sshkey_list_url
    sshkey_list_url = 'https://api.vultr.com/v1/sshkey/list?api_key=' + Vultr.api_key
    assert_equal sshkey_list_url, Vultr::SSHKey._list
  end

  def test_sshkey_create_url
    sshkey_create_url = 'https://api.vultr.com/v1/sshkey/create?api_key=' + Vultr.api_key
    assert_equal sshkey_create_url, Vultr::SSHKey._create
  end

  def test_sshkey_destroy_url
    sshkey_destroy_url = 'https://api.vultr.com/v1/sshkey/destroy?api_key=' + Vultr.api_key
    assert_equal sshkey_destroy_url, Vultr::SSHKey._destroy
  end

  def test_sshkey_update_url
    sshkey_update_url = 'https://api.vultr.com/v1/sshkey/update?api_key=' + Vultr.api_key
    assert_equal sshkey_update_url, Vultr::SSHKey._update
  end

  def test_sshkey_responses
    r = Vultr::SSHKey.create(name: 'test_ssh_key',
                             ssh_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJMDEZ80TRG4FMi3lz4zonNnUlSUd92UfOEh2OtS6Rtl9X/2vqqnbxh4tbCNUH6JGEHhjXV6JKoj3G1Tui+7keTLov9vGWJsgDCIndU5r/wUp6G99oAMpoldsuUXjh1xKYT6XrF6ud1Rd3WIFuzZAgv/dTBD+tUWr53YngqN1hJ7Ux4pxu4whMpdiaeom8cVp+u8pI9n06ESgMClPe2eloFOd1agsOmhLL4YrTveGf7DHLED39rkcEvRBSalM2q5frY0x5gx2QTDv85cHHM2gsHgJB4CwRajPUYnqjA+YH/QZIq629z29YJP3odcyDVIiFQuqCtxYPoakfTzoSP3zx tolbkni@gmail.com')

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]

    sshkey_id = r[:result]['SSHKEYID']

    r = Vultr::SSHKey.update(SSHKEYID: sshkey_id,
                             name: 'test_ssh_key1',
                             ssh_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJMDEZ80TRG4FMi3lz4zonNnUlSUd92UfOEh2OtS6Rtl9X/2vqqnbxh4tbCNUH6JGEHhjXV6JKoj3G1Tui+7keTLov9vGWJsgDCIndU5r/wUp6G99oAMpoldsuUXjh1xKYT6XrF6ud1Rd3WIFuzZAgv/dTBD+tUWr53YngqN1hJ7Ux4pxu4whMpdiaeom8cVp+u8pI9n06ESgMClPe2eloFOd1agsOmhLL4YrTveGf7DHLED39rkcEvRBSalM2q5frY0x5gx2QTDv85cHHM2gsHgJB4CwRajPUYnqjA+YH/QZIq629z29YJP3odcyDVIiFQuqCtxYPoakfTzoSP3zx tolbkni@gmail.com')

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_empty r[:result]

    r = Vultr::SSHKey.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]

    r = Vultr::SSHKey.destroy(SSHKEYID: sshkey_id)
    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_empty r[:result]
  end

  def teardown
    # Do nothing
  end
end