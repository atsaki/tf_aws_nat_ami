# tf_aws_nat_ami
Terraform module to find Amazon linux NAT instance AMI

## Input variables

* region - E.g. eu-central-1
* version - E.g. 2015.03.0 (default: 2015.03.0)
* virttype - hvm or pv (default: hvm)
* volumetype - gp2 or ebs (default: gp2)

## Outputs

* ami_id

## Examples

```text
module "nat_ami" {
  source = "github.com/atsaki/tf_aws_nat_ami"
  region = "eu-central-1"
}

resource "aws_instance" "nat" {
  ami = "${module.nat_ami.ami_id}"
  instance_type = "t2.micro"
  ...
}
```

## Update AMI list

The AMI list shuould be updated when new versions are released.
You can update AMI list in the following steps.

1. Install AWS SDK for Ruby

    ```bash
    $ bundle install --path vendor/bundle
    ```

2. Set up AWS credentials by ```~/.aws/credentials``` or environment varialbles

    [Setting up AWS Credentials for Use with the SDK for Ruby](http://docs.aws.amazon.com/AWSSdkDocsRuby/latest/DeveloperGuide/set-up-creds.html)

3. Remove old variables.tf.json

   ```bash
   $ rm variables.tf.json
   ```

4. Run make

    ```bash
    $ make
    ```

5. Update default version of main.tf and README.md

6. Commit changes

## Notes

Most of the module is based on

* [terraform-community-modules/tf_aws_ubuntu_ami](https://github.com/terraform-community-modules/tf_aws_ubuntu_ami)
* [terraform-community-modules/tf_aws_fedora_ami](https://github.com/terraform-community-modules/tf_aws_fedora_ami)
