
# commands

```sh
# init & validate
terraform init
terraform validate

# workspaces
terraform workspace new prod
terraform workspace new dev
terraform workspace list
terraform workspace show
terraform workspace select prod

# fmt
terraform fmt

# apply
terraform plan
terraform apply
terraform destroy

# choose var file
terraform apply -var-file dev.tfvars
```
