{{- define "clusters.get-tenants" -}}
{{- $tenants := list -}}
{{- range $path, $_ :=  .Files.Glob (print "tenants/" $.Values.clusterName "/**.yaml") -}}
{{- $tenantDefaults := $.Files.Get "tenants/defaults.yaml" | fromYaml }}
{{- $tenantClusterDefaults := $.Files.Get (print "cluster-tenants/" $.Values.clusterName ".yaml") | fromYaml  }}
{{- $tenantSpecific := $.Files.Get $path | fromYaml }}
{{- $yamlMerged := merge $tenantSpecific $tenantClusterDefaults $tenantDefaults }}
{{- $tenants = append $tenants $yamlMerged -}}
{{- end -}}
{{- $tenants | toYaml -}}
{{- end -}}

{{- define "clusters.get-tenant-resources" -}}
{{- $resources := $.Files.Get (print "tenant-resources.yaml") | fromYaml }}
{{- $resources.list | toYaml -}}
{{- end -}}