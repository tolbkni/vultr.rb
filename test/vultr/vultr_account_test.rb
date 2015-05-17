require 'test/test_helper'

class VultrAccountTest < Minitest::Test

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_account_info_url
    account_info_url = 'https://api.vultr.com/v1/account/info?api_key=' + Vultr.api_key
    assert_equal account_info_url, Vultr::Account._info
  end

  def test_account_info_response
    r = Vultr::Account.info

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert r[:result].has_key? 'balance'
    assert r[:result].has_key? 'pending_charges'
    assert r[:result].has_key? 'last_payment_date'
    assert r[:result].has_key? 'last_payment_amount'
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end
end
