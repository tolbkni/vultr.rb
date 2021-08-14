module Vultr
  class KubernetesResource < Resource
    def
      Kubernetes.new get_request("kubernetes/clusters").body
    end
  end
end

