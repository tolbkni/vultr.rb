# frozen_string_literal: true

require "test_helper"

class KubernetesResourceTest < Minitest::Test
  def test_list
    stub = stub_request("kubernetes/clusters", response: stub_response(fixture: "kubernetes/list"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    kubernetes = client.kubernetes.list

    assert_equal Vultr::Collection, kubernetes.class
    assert_equal Vultr::KubernetesCluster, kubernetes.data.first.class
    assert_equal 2, kubernetes.total
    assert_equal "next", kubernetes.next_cursor
    assert_equal "prev", kubernetes.prev_cursor
  end

  def test_create
    body = {label: "vke", region: "lax", version: "v1.20.0+1", node_pools: [{node_quantity: 2, label: "my-label", plan: "vc2-1c-2gb"}]}
    stub = stub_request("kubernetes/clusters", method: :post, body: body, response: stub_response(fixture: "kubernetes/create", status: 201))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    kubernetes = client.kubernetes.create(**body)

    assert_equal kubernetes.id, "455dcd32-e621-48ee-a10e-0cb5f754e13e"
    assert_equal kubernetes.label, "vke"
    assert_equal kubernetes.date_created, Time.parse("2021-07-07T22:57:01+00:00")
    assert_equal kubernetes.cluster_subnet, "10.244.0.0/16"
    assert_equal kubernetes.service_subnet, "10.96.0.0/12"
    assert_equal kubernetes.ip, "0.0.0.0"
    assert_equal kubernetes.endpoint, "455dcd32-e621-48ee-a10e-0cb5f754e13e.vultr-k8s.com"
    assert_equal kubernetes.version, "v1.20.0+1"
    assert_equal kubernetes.region, "lax"
    assert_equal kubernetes.status, "pending"
    assert_equal kubernetes.node_pools.class, Array
  end

  def test_retrieve
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("kubernetes/clusters/#{vke_id}", response: stub_response(fixture: "kubernetes/retrieve"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    vke_cluster = client.kubernetes.retrieve(vke_id: vke_id)

    assert_equal vke_cluster.id, "455dcd32-e621-48ee-a10e-0cb5f754e13e"
    assert_equal vke_cluster.label, "vke"
    assert_equal vke_cluster.date_created, Time.parse("2021-07-07T22:57:01+00:00")
    assert_equal vke_cluster.cluster_subnet, "10.244.0.0/16"
    assert_equal vke_cluster.service_subnet, "10.96.0.0/12"
    assert_equal vke_cluster.ip, "207.246.109.187"
    assert_equal vke_cluster.endpoint, "455dcd32-e621-48ee-a10e-0cb5f754e13e.vultr-k8s.com"
    assert_equal vke_cluster.version, "v1.20.0+1"
    assert_equal vke_cluster.region, "lax"
    assert_equal vke_cluster.status, "active"
    assert_equal vke_cluster.node_pools.class, Array
  end

  def test_update
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {label: "My New Label"}
    stub = stub_request("kubernetes/clusters/#{vke_id}", method: :put, body: body, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    assert client.kubernetes.update(vke_id: vke_id, **body)
  end

  def test_delete
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("kubernetes/clusters/#{vke_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.kubernetes.delete(vke_id: vke_id)
  end

  def test_config
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("kubernetes/clusters/#{vke_id}/config", response: stub_response(fixture: "kubernetes/config"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    vke_cluster = client.kubernetes.config(vke_id: vke_id)

    assert_equal vke_cluster.kube_config, "kube_config"
  end

  def test_list_resources
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("kubernetes/clusters/#{vke_id}/resources", response: stub_response(fixture: "kubernetes/list_resources"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    vke_cluster = client.kubernetes.list_resources(vke_id: vke_id)

    assert_equal vke_cluster.block_storage.class, Array
    assert_equal vke_cluster.load_balancer.class, Array
  end

  def test_list_node_pools
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools", response: stub_response(fixture: "kubernetes/list_node_pools"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    node_pools = client.kubernetes.list_node_pools(vke_id: vke_id)

    assert_equal Vultr::Collection, node_pools.class
    assert_equal Vultr::Object, node_pools.data.first.class
    assert_equal 2, node_pools.total
    assert_equal "next", node_pools.next_cursor
    assert_equal "prev", node_pools.prev_cursor
  end

  def test_retrieve_node_pool
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    nodepool_id = "e97bdee9-2781-4f31-be03-60fc75f399ae"

    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools/#{nodepool_id}", response: stub_response(fixture: "kubernetes/retrieve_node_pool"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    node_pool = client.kubernetes.retrieve_node_pool(vke_id: vke_id, nodepool_id: nodepool_id)

    assert_equal node_pool.id, "e97bdee9-2781-4f31-be03-60fc75f399ae"
    assert_equal node_pool.date_created, Time.parse("2021-07-07T23:27:08+00:00")
    assert_equal node_pool.date_updated, Time.parse("2021-07-08T12:12:44+00:00")
    assert_equal node_pool.label, "my-label-48770703"
    assert_equal node_pool.plan_id, "vc2-1c-2gb"
    assert_equal node_pool.status, "active"
    assert_equal node_pool.count, 2
    assert_equal node_pool.nodes.class, Array
  end

  def test_create_node_pool
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    body = {node_quantity: 2, label: "nodepool", paln: "vc2-lc-2gb"}
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools", method: :post, body: body, response: stub_response(fixture: "kubernetes/create_node_pool"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    node_pool = client.kubernetes.create_node_pool(vke_id: vke_id, **body)

    assert_equal node_pool.id, "4130764b-5276-4552-546f-32513239732b"
    assert_equal node_pool.date_created, Time.parse("2021-07-07T23:29:18+00:00")
    assert_equal node_pool.date_updated, Time.parse("2021-07-08T23:29:18+00:00")
    assert_equal node_pool.label, "nodepool-48770716"
    assert_equal node_pool.plan_id, "vc2-1c-2gb"
    assert_equal node_pool.status, "pending"
    assert_equal node_pool.count, 2
    assert_equal node_pool.nodes.class, Array
  end

  def test_update_node_pool
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    nodepool_id = "e97bdee9-2781-4f31-be03-60fc75f399ae"
    body = {node_quantity: 1}
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools/#{nodepool_id}", method: :patch, body: body, response: stub_response(fixture: "kubernetes/update_node_pool"))
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)
    node_pool = client.kubernetes.update_node_pool(vke_id: vke_id, nodepool_id: nodepool_id, **body)

    assert_equal node_pool.id, "e97bdee9-2781-4f31-be03-60fc75f399ae"
    assert_equal node_pool.date_created, Time.parse("2021-07-07T23:27:08+00:00")
    assert_equal node_pool.date_updated, Time.parse("2021-07-08T12:12:44+00:00")
    assert_equal node_pool.label, "my-label-48770703"
    assert_equal node_pool.plan_id, "vc2-1c-2gb"
    assert_equal node_pool.status, "active"
    assert_equal node_pool.count, 1
    assert_equal node_pool.nodes.class, Array
  end

  def test_delete_node_pool
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    nodepool_id = "e97bdee9-2781-4f31-be03-60fc75f399ae"
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools/#{nodepool_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.kubernetes.delete_node_pool(vke_id: vke_id, nodepool_id: nodepool_id)
  end

  def test_delete_node_pool_instance
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    nodepool_id = "e97bdee9-2781-4f31-be03-60fc75f399ae"
    node_id = "ab809b79-1358-4c59-8c8e-b73add699bf9"
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools/#{nodepool_id}/nodes/#{node_id}", method: :delete, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.kubernetes.delete_node_pool_instance(vke_id: vke_id, nodepool_id: nodepool_id, node_id: node_id)
  end

  def test_recycle_node_pool_instance
    vke_id = "cb676a46-66fd-4dfb-b839-443f2e6c0b60"
    nodepool_id = "e97bdee9-2781-4f31-be03-60fc75f399ae"
    node_id = "ab809b79-1358-4c59-8c8e-b73add699bf9"
    stub = stub_request("kubernetes/clusters/#{vke_id}/node-pools/#{nodepool_id}/nodes/#{node_id}/recycle", method: :post, response: {})
    client = Vultr::Client.new(api_key: "fake", adapter: :test, stubs: stub)

    assert client.kubernetes.recycle_node_pool_instance(vke_id: vke_id, nodepool_id: nodepool_id, node_id: node_id)
  end
end
