require 'test/test_helper'

class VultrStartupscriptTest < Minitest::Test

  def setup
    Vultr.api_key = ENV['VULTR_API_KEY']
  end

  def test_startupscript_list_url
    startupscript_list_url = 'https://api.vultr.com/v1/startupscript/list?api_key=' + Vultr.api_key
    assert_equal startupscript_list_url, Vultr::StartupScript._list

  end

  def test_startupscript_create_url
    startupscript_create_url = 'https://api.vultr.com/v1/startupscript/create?api_key=' + Vultr.api_key
    assert_equal startupscript_create_url, Vultr::StartupScript._create
  end

  def test_startupscript_destroy_url
    startupscript_destroy_url = 'https://api.vultr.com/v1/startupscript/destroy?api_key=' + Vultr.api_key
    assert_equal startupscript_destroy_url, Vultr::StartupScript._destroy
  end

  def test_startupscript_update_url
    startupscript_update_url = 'https://api.vultr.com/v1/startupscript/update?api_key=' + Vultr.api_key
    assert_equal startupscript_update_url, Vultr::StartupScript._update
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