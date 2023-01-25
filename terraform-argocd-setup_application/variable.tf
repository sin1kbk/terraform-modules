variable "application_parameters" {
  description = "These paths will be registered with Argocd application."
  type = list(
    object({
      repository : string
      applications : list(object({
        name : string
        namespace : string
        path : string
        value_files : list(string)
      })),
    })
  )
}
