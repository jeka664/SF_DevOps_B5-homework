## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.81.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_createservers_1"></a> [createservers\_1](#module\_createservers\_1) | ./modules/createservers | n/a |
| <a name="module_createservers_2"></a> [createservers\_2](#module\_createservers\_2) | ./modules/createservers | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_lb_network_load_balancer.nlb](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer) | resource |
| [yandex_lb_target_group.nlb_tg](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group) | resource |
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet1](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_var_cloud_id"></a> [var\_cloud\_id](#input\_var\_cloud\_id) | cloud\_id | `string` | `"b1ge7ag1gb5nrv9dbhe7"` | no |
| <a name="input_var_folder_id"></a> [var\_folder\_id](#input\_var\_folder\_id) | folder\_id | `string` | `"b1g46bklm25efh7fh01a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm1"></a> [external\_ip\_address\_vm1](#output\_external\_ip\_address\_vm1) | n/a |
| <a name="output_external_ip_address_vm2"></a> [external\_ip\_address\_vm2](#output\_external\_ip\_address\_vm2) | n/a |
| <a name="output_internal_ip_address_vm1"></a> [internal\_ip\_address\_vm1](#output\_internal\_ip\_address\_vm1) | n/a |
| <a name="output_internal_ip_address_vm2"></a> [internal\_ip\_address\_vm2](#output\_internal\_ip\_address\_vm2) | n/a |
| <a name="output_load_balancer_public_ip"></a> [load\_balancer\_public\_ip](#output\_load\_balancer\_public\_ip) | Public IP address of load balancer |
