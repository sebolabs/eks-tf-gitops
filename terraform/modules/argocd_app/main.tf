resource "helm_release" "argocd_application" {
  for_each = { for k, v in var.applications : k => merge(local.default_helm_application, v) }

  name      = each.key
  chart     = "${path.module}/argocd-application/helm"
  version   = "1.0.0"
  namespace = each.value.namespace #

  set {
    name  = "name"
    value = each.key
    type  = "string"
  }

  set {
    name  = "namespace"
    value = each.key
    type  = "string"
  }

  set {
    name  = "project"
    value = each.value.project
    type  = "string"
  }

  set {
    name  = "source.repoUrl"
    value = each.value.repo_url
    type  = "string"
  }

  set {
    name  = "source.targetRevision"
    value = each.value.target_revision
    type  = "string"
  }

  set {
    name  = "source.path"
    value = each.value.path
    type  = "string"
  }

  set {
    name  = "source.helm.releaseName"
    value = each.key
    type  = "string"
  }

  set {
    name = "source.helm.values"
    value = yamlencode(merge(
      { repoUrl = each.value.repo_url },
      each.value.values,
      local.global_application_values,
      {},
    ))
    type = "auto"
  }

  # Destination Config.
  set {
    name  = "destination.server"
    value = each.value.destination
    type  = "string"
  }

  values = [
    # Application ignoreDifferences
    yamlencode({
      "ignoreDifferences" = lookup(each.value, "ignoreDifferences", [])
    })
  ]
}

# TODO: add support for SSM PS
resource "kubernetes_secret" "argocd_gitops" {
  for_each = { for k, v in var.applications : k => v if try(v.ssh_key_secret_name, null) != null }

  metadata {
    name      = "${each.key}-repo-secret"
    namespace = each.value.namespace #
    labels    = { "argocd.argoproj.io/secret-type" : "repository" }
  }

  data = {
    insecure      = lookup(each.value, "insecure", false)
    sshPrivateKey = data.aws_secretsmanager_secret_version.ssh_key_version[each.key].secret_string
    type          = "git"
    url           = each.value.repo_url
  }
}
