require 'test_helper'

class VultrStartupscriptTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_startupscript_responses
    r = Vultr::StartupScript.create(name: 'test_startup_script',
                                  script: 'echo \'test\'',
                                  type: 'boot')

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]

    script_id = r[:result]['SCRIPTID']

    r = Vultr::StartupScript.update(SCRIPTID: script_id,
                                    name: 'test_startup_script1',
                                    script: 'echo \'test1\'')

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_empty r[:result]

    r = Vultr::StartupScript.list

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_instance_of Hash, r[:result]


    r = Vultr::StartupScript.destroy(SCRIPTID: script_id)

    assert r.has_key? :status
    assert_equal r[:status], 200

    assert r.has_key? :result
    assert_empty r[:result]
  end

  def teardown
    # Do nothing
  end
end
