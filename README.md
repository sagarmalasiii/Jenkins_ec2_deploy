Terraform + Jenkins Pipeline for EC2 with Auto Scaling Group and User Data
Overview
This guide outlines the step-by-step process for deploying an EC2 instance using an Auto Scaling Group (ASG) and Launch Template with a user data script. The deployment is automated through a Jenkins pipeline integrated with Terraform.
Step 1: Prerequisites
- AWS account and IAM user with programmatic access
- Jenkins installed and running
- Terraform installed on the Jenkins machine
- AWS CLI installed (optional for verification)
- Jenkins credentials configured for AWS access and secret keys
Step 2: Store AWS Credentials in Jenkins
1. Go to Jenkins > Manage Jenkins > Credentials > Global > Add Credentials
2. Add two credentials:
   - aws_access_key (Secret Text)
   - aws_secret_key (Secret Text)
Step 3: Create Terraform Files
1. `main.tf`: Defines the provider, security group, launch template, and ASG
2. `variables.tf`: Declares variables for AWS credentials
3. `user_data.sh`: Script to install NGINX and set up a default web page
4. `outputs.tf`: (Optional) Outputs for IP or ASG information
Step 4: Configure the Jenkinsfile
Write a pipeline that:
- Checks out the Git repo
- Initializes Terraform
- Executes Terraform plan and apply with credentials
- Requests manual approval before applying changes
Step 5: Push Code to GitHub
Push your Terraform and Jenkins pipeline code to a GitHub repository.
Step 6: Trigger Jenkins Job
Run the Jenkins job manually or configure it to trigger on git push.
Step 7: Verification
After deployment, visit the EC2 instance's public IP to verify the NGINX welcome message.
You can also use AWS CLI:
aws autoscaling describe-auto-scaling-groups
aws ec2 describe-instances
Cleanup
Run `terraform destroy` from the Jenkinsfile or terminal with AWS credentials to tear down resources.


#####Console Output####
Started by user Sagar Malasi

Obtained Jenkinsfile from git https://github.com/sagarmalasiii/Jenkins_ec2_deploy
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins
 in /var/lib/jenkins/workspace/ec2_deploy
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/ec2_deploy/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/sagarmalasiii/Jenkins_ec2_deploy # timeout=10
Fetching upstream changes from https://github.com/sagarmalasiii/Jenkins_ec2_deploy
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
 > git fetch --tags --force --progress -- https://github.com/sagarmalasiii/Jenkins_ec2_deploy +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 32a26d0f286607bbac51021a6e3f66ce7ae4cf7a (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 32a26d0f286607bbac51021a6e3f66ce7ae4cf7a # timeout=10
Commit message: "Final Version"
 > git rev-list --no-walk 6cfce7f88ec53e7b4847dc29ae1350fc1ffded06 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout Code)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/ec2_deploy/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/sagarmalasiii/Jenkins_ec2_deploy # timeout=10
Fetching upstream changes from https://github.com/sagarmalasiii/Jenkins_ec2_deploy
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
 > git fetch --tags --force --progress -- https://github.com/sagarmalasiii/Jenkins_ec2_deploy +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 32a26d0f286607bbac51021a6e3f66ce7ae4cf7a (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 32a26d0f286607bbac51021a6e3f66ce7ae4cf7a # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main 32a26d0f286607bbac51021a6e3f66ce7ae4cf7a # timeout=10
Commit message: "Final Version"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] sh
+ terraform init
[0m[1mInitializing the backend...[0m
[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.99.1

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Plan)
[Pipeline] sh
+ terraform plan
[0m[1maws_instance.myec2: Refreshing state... [id=i-0947e1d8ccdcef68c][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
  [31m-[0m destroy[0m

Terraform will perform the following actions:

[1m  # aws_autoscaling_group.example[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "example" {
      [32m+[0m[0m arn                              = (known after apply)
      [32m+[0m[0m availability_zones               = (known after apply)
      [32m+[0m[0m default_cooldown                 = (known after apply)
      [32m+[0m[0m desired_capacity                 = 1
      [32m+[0m[0m force_delete                     = true
      [32m+[0m[0m force_delete_warm_pool           = false
      [32m+[0m[0m health_check_grace_period        = 300
      [32m+[0m[0m health_check_type                = "EC2"
      [32m+[0m[0m id                               = (known after apply)
      [32m+[0m[0m ignore_failed_scaling_activities = false
      [32m+[0m[0m load_balancers                   = (known after apply)
      [32m+[0m[0m max_size                         = 2
      [32m+[0m[0m metrics_granularity              = "1Minute"
      [32m+[0m[0m min_size                         = 1
      [32m+[0m[0m name                             = "jenkins-asg-demo"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0b6dd7690769ced7e",
          [32m+[0m[0m "subnet-0c1b59f28843d6284",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m availability_zone_distribution (known after apply)

      [32m+[0m[0m capacity_reservation_specification (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m mixed_instances_policy (known after apply)

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "ASG Instance"
        }

      [32m+[0m[0m traffic_source (known after apply)
    }

[1m  # aws_instance.myec2[0m will be [1m[31mdestroyed[0m
  # (because aws_instance.myec2 is not in configuration)
[0m  [31m-[0m[0m resource "aws_instance" "myec2" {
      [31m-[0m[0m ami                                  = "ami-02457590d33d576c3" [90m-> null[0m[0m
      [31m-[0m[0m arn                                  = "arn:aws:ec2:us-east-1:730335211981:instance/i-0947e1d8ccdcef68c" [90m-> null[0m[0m
      [31m-[0m[0m associate_public_ip_address          = true [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                    = "us-east-1b" [90m-> null[0m[0m
      [31m-[0m[0m cpu_core_count                       = 1 [90m-> null[0m[0m
      [31m-[0m[0m cpu_threads_per_core                 = 1 [90m-> null[0m[0m
      [31m-[0m[0m disable_api_stop                     = false [90m-> null[0m[0m
      [31m-[0m[0m disable_api_termination              = false [90m-> null[0m[0m
      [31m-[0m[0m ebs_optimized                        = false [90m-> null[0m[0m
      [31m-[0m[0m get_password_data                    = false [90m-> null[0m[0m
      [31m-[0m[0m hibernation                          = false [90m-> null[0m[0m
      [31m-[0m[0m id                                   = "i-0947e1d8ccdcef68c" [90m-> null[0m[0m
      [31m-[0m[0m instance_initiated_shutdown_behavior = "stop" [90m-> null[0m[0m
      [31m-[0m[0m instance_state                       = "running" [90m-> null[0m[0m
      [31m-[0m[0m instance_type                        = "t2.micro" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_address_count                   = 0 [90m-> null[0m[0m
      [31m-[0m[0m ipv6_addresses                       = [] [90m-> null[0m[0m
      [31m-[0m[0m monitoring                           = false [90m-> null[0m[0m
      [31m-[0m[0m placement_partition_number           = 0 [90m-> null[0m[0m
      [31m-[0m[0m primary_network_interface_id         = "eni-0421f3ae36b42aa99" [90m-> null[0m[0m
      [31m-[0m[0m private_dns                          = "ip-172-31-92-246.ec2.internal" [90m-> null[0m[0m
      [31m-[0m[0m private_ip                           = "172.31.92.246" [90m-> null[0m[0m
      [31m-[0m[0m public_dns                           = "ec2-18-207-219-32.compute-1.amazonaws.com" [90m-> null[0m[0m
      [31m-[0m[0m public_ip                            = "18.207.219.32" [90m-> null[0m[0m
      [31m-[0m[0m secondary_private_ips                = [] [90m-> null[0m[0m
      [31m-[0m[0m security_groups                      = [
          [31m-[0m[0m "default",
        ] [90m-> null[0m[0m
      [31m-[0m[0m source_dest_check                    = true [90m-> null[0m[0m
      [31m-[0m[0m subnet_id                            = "subnet-0c1b59f28843d6284" [90m-> null[0m[0m
      [31m-[0m[0m tags                                 = {
          [31m-[0m[0m "Name" = "JenkinsDeployedEC2"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                             = {
          [31m-[0m[0m "Name" = "JenkinsDeployedEC2"
        } [90m-> null[0m[0m
      [31m-[0m[0m tenancy                              = "default" [90m-> null[0m[0m
      [31m-[0m[0m user_data_replace_on_change          = false [90m-> null[0m[0m
      [31m-[0m[0m vpc_security_group_ids               = [
          [31m-[0m[0m "sg-04d4b72ffd15e9b7b",
        ] [90m-> null[0m[0m
        [90m# (8 unchanged attributes hidden)[0m[0m

      [31m-[0m[0m capacity_reservation_specification {
          [31m-[0m[0m capacity_reservation_preference = "open" [90m-> null[0m[0m
        }

      [31m-[0m[0m cpu_options {
          [31m-[0m[0m core_count       = 1 [90m-> null[0m[0m
          [31m-[0m[0m threads_per_core = 1 [90m-> null[0m[0m
            [90m# (1 unchanged attribute hidden)[0m[0m
        }

      [31m-[0m[0m credit_specification {
          [31m-[0m[0m cpu_credits = "standard" [90m-> null[0m[0m
        }

      [31m-[0m[0m enclave_options {
          [31m-[0m[0m enabled = false [90m-> null[0m[0m
        }

      [31m-[0m[0m maintenance_options {
          [31m-[0m[0m auto_recovery = "default" [90m-> null[0m[0m
        }

      [31m-[0m[0m metadata_options {
          [31m-[0m[0m http_endpoint               = "enabled" [90m-> null[0m[0m
          [31m-[0m[0m http_protocol_ipv6          = "disabled" [90m-> null[0m[0m
          [31m-[0m[0m http_put_response_hop_limit = 2 [90m-> null[0m[0m
          [31m-[0m[0m http_tokens                 = "required" [90m-> null[0m[0m
          [31m-[0m[0m instance_metadata_tags      = "disabled" [90m-> null[0m[0m
        }

      [31m-[0m[0m private_dns_name_options {
          [31m-[0m[0m enable_resource_name_dns_a_record    = false [90m-> null[0m[0m
          [31m-[0m[0m enable_resource_name_dns_aaaa_record = false [90m-> null[0m[0m
          [31m-[0m[0m hostname_type                        = "ip-name" [90m-> null[0m[0m
        }

      [31m-[0m[0m root_block_device {
          [31m-[0m[0m delete_on_termination = true [90m-> null[0m[0m
          [31m-[0m[0m device_name           = "/dev/xvda" [90m-> null[0m[0m
          [31m-[0m[0m encrypted             = false [90m-> null[0m[0m
          [31m-[0m[0m iops                  = 3000 [90m-> null[0m[0m
          [31m-[0m[0m tags                  = {} [90m-> null[0m[0m
          [31m-[0m[0m tags_all              = {} [90m-> null[0m[0m
          [31m-[0m[0m throughput            = 125 [90m-> null[0m[0m
          [31m-[0m[0m volume_id             = "vol-0405c370d9b1abf67" [90m-> null[0m[0m
          [31m-[0m[0m volume_size           = 8 [90m-> null[0m[0m
          [31m-[0m[0m volume_type           = "gp3" [90m-> null[0m[0m
            [90m# (1 unchanged attribute hidden)[0m[0m
        }
    }

[1m  # aws_launch_template.example[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "example" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-02457590d33d576c3"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = (known after apply)
      [32m+[0m[0m name_prefix     = "jenkins-demo-"
      [32m+[0m[0m tags_all        = (known after apply)
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKc3VkbyBhcHQgdXBkYXRlCnN1ZG8gYXB0IGluc3RhbGwgLXkgbmdpbngKZWNobyAiSGVsbG8gZnJvbSBUZXJyYWZvcm0gd2l0aCBVc2VyIERhdGEhIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo="

      [32m+[0m[0m metadata_options (known after apply)
    }

[1mPlan:[0m 2 to add, 0 to change, 1 to destroy.
[0m[90m
─────────────────────────────────────────────────────────────────────────────[0m

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Apply)
[Pipeline] input
Apply changes?
Proceed or Abort
Approved by Sagar Malasi

[Pipeline] sh
+ terraform apply -auto-approve
[0m[1maws_instance.myec2: Refreshing state... [id=i-0947e1d8ccdcef68c][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m
  [31m-[0m destroy[0m

Terraform will perform the following actions:

[1m  # aws_autoscaling_group.example[0m will be created
[0m  [32m+[0m[0m resource "aws_autoscaling_group" "example" {
      [32m+[0m[0m arn                              = (known after apply)
      [32m+[0m[0m availability_zones               = (known after apply)
      [32m+[0m[0m default_cooldown                 = (known after apply)
      [32m+[0m[0m desired_capacity                 = 1
      [32m+[0m[0m force_delete                     = true
      [32m+[0m[0m force_delete_warm_pool           = false
      [32m+[0m[0m health_check_grace_period        = 300
      [32m+[0m[0m health_check_type                = "EC2"
      [32m+[0m[0m id                               = (known after apply)
      [32m+[0m[0m ignore_failed_scaling_activities = false
      [32m+[0m[0m load_balancers                   = (known after apply)
      [32m+[0m[0m max_size                         = 2
      [32m+[0m[0m metrics_granularity              = "1Minute"
      [32m+[0m[0m min_size                         = 1
      [32m+[0m[0m name                             = "jenkins-asg-demo"
      [32m+[0m[0m name_prefix                      = (known after apply)
      [32m+[0m[0m predicted_capacity               = (known after apply)
      [32m+[0m[0m protect_from_scale_in            = false
      [32m+[0m[0m service_linked_role_arn          = (known after apply)
      [32m+[0m[0m target_group_arns                = (known after apply)
      [32m+[0m[0m vpc_zone_identifier              = [
          [32m+[0m[0m "subnet-0b6dd7690769ced7e",
          [32m+[0m[0m "subnet-0c1b59f28843d6284",
        ]
      [32m+[0m[0m wait_for_capacity_timeout        = "10m"
      [32m+[0m[0m warm_pool_size                   = (known after apply)

      [32m+[0m[0m availability_zone_distribution (known after apply)

      [32m+[0m[0m capacity_reservation_specification (known after apply)

      [32m+[0m[0m launch_template {
          [32m+[0m[0m id      = (known after apply)
          [32m+[0m[0m name    = (known after apply)
          [32m+[0m[0m version = "$Latest"
        }

      [32m+[0m[0m mixed_instances_policy (known after apply)

      [32m+[0m[0m tag {
          [32m+[0m[0m key                 = "Name"
          [32m+[0m[0m propagate_at_launch = true
          [32m+[0m[0m value               = "ASG Instance"
        }

      [32m+[0m[0m traffic_source (known after apply)
    }

[1m  # aws_instance.myec2[0m will be [1m[31mdestroyed[0m
  # (because aws_instance.myec2 is not in configuration)
[0m  [31m-[0m[0m resource "aws_instance" "myec2" {
      [31m-[0m[0m ami                                  = "ami-02457590d33d576c3" [90m-> null[0m[0m
      [31m-[0m[0m arn                                  = "arn:aws:ec2:us-east-1:730335211981:instance/i-0947e1d8ccdcef68c" [90m-> null[0m[0m
      [31m-[0m[0m associate_public_ip_address          = true [90m-> null[0m[0m
      [31m-[0m[0m availability_zone                    = "us-east-1b" [90m-> null[0m[0m
      [31m-[0m[0m cpu_core_count                       = 1 [90m-> null[0m[0m
      [31m-[0m[0m cpu_threads_per_core                 = 1 [90m-> null[0m[0m
      [31m-[0m[0m disable_api_stop                     = false [90m-> null[0m[0m
      [31m-[0m[0m disable_api_termination              = false [90m-> null[0m[0m
      [31m-[0m[0m ebs_optimized                        = false [90m-> null[0m[0m
      [31m-[0m[0m get_password_data                    = false [90m-> null[0m[0m
      [31m-[0m[0m hibernation                          = false [90m-> null[0m[0m
      [31m-[0m[0m id                                   = "i-0947e1d8ccdcef68c" [90m-> null[0m[0m
      [31m-[0m[0m instance_initiated_shutdown_behavior = "stop" [90m-> null[0m[0m
      [31m-[0m[0m instance_state                       = "shutting-down" [90m-> null[0m[0m
      [31m-[0m[0m instance_type                        = "t2.micro" [90m-> null[0m[0m
      [31m-[0m[0m ipv6_address_count                   = 0 [90m-> null[0m[0m
      [31m-[0m[0m ipv6_addresses                       = [] [90m-> null[0m[0m
      [31m-[0m[0m monitoring                           = false [90m-> null[0m[0m
      [31m-[0m[0m placement_partition_number           = 0 [90m-> null[0m[0m
      [31m-[0m[0m primary_network_interface_id         = "eni-0421f3ae36b42aa99" [90m-> null[0m[0m
      [31m-[0m[0m private_dns                          = "ip-172-31-92-246.ec2.internal" [90m-> null[0m[0m
      [31m-[0m[0m private_ip                           = "172.31.92.246" [90m-> null[0m[0m
      [31m-[0m[0m public_dns                           = "ec2-18-207-219-32.compute-1.amazonaws.com" [90m-> null[0m[0m
      [31m-[0m[0m public_ip                            = "18.207.219.32" [90m-> null[0m[0m
      [31m-[0m[0m secondary_private_ips                = [] [90m-> null[0m[0m
      [31m-[0m[0m security_groups                      = [
          [31m-[0m[0m "default",
        ] [90m-> null[0m[0m
      [31m-[0m[0m source_dest_check                    = true [90m-> null[0m[0m
      [31m-[0m[0m subnet_id                            = "subnet-0c1b59f28843d6284" [90m-> null[0m[0m
      [31m-[0m[0m tags                                 = {
          [31m-[0m[0m "Name" = "JenkinsDeployedEC2"
        } [90m-> null[0m[0m
      [31m-[0m[0m tags_all                             = {
          [31m-[0m[0m "Name" = "JenkinsDeployedEC2"
        } [90m-> null[0m[0m
      [31m-[0m[0m tenancy                              = "default" [90m-> null[0m[0m
      [31m-[0m[0m user_data_replace_on_change          = false [90m-> null[0m[0m
      [31m-[0m[0m vpc_security_group_ids               = [
          [31m-[0m[0m "sg-04d4b72ffd15e9b7b",
        ] [90m-> null[0m[0m
        [90m# (8 unchanged attributes hidden)[0m[0m

      [31m-[0m[0m capacity_reservation_specification {
          [31m-[0m[0m capacity_reservation_preference = "open" [90m-> null[0m[0m
        }

      [31m-[0m[0m cpu_options {
          [31m-[0m[0m core_count       = 1 [90m-> null[0m[0m
          [31m-[0m[0m threads_per_core = 1 [90m-> null[0m[0m
            [90m# (1 unchanged attribute hidden)[0m[0m
        }

      [31m-[0m[0m credit_specification {
          [31m-[0m[0m cpu_credits = "standard" [90m-> null[0m[0m
        }

      [31m-[0m[0m enclave_options {
          [31m-[0m[0m enabled = false [90m-> null[0m[0m
        }

      [31m-[0m[0m maintenance_options {
          [31m-[0m[0m auto_recovery = "default" [90m-> null[0m[0m
        }

      [31m-[0m[0m metadata_options {
          [31m-[0m[0m http_endpoint               = "enabled" [90m-> null[0m[0m
          [31m-[0m[0m http_protocol_ipv6          = "disabled" [90m-> null[0m[0m
          [31m-[0m[0m http_put_response_hop_limit = 2 [90m-> null[0m[0m
          [31m-[0m[0m http_tokens                 = "required" [90m-> null[0m[0m
          [31m-[0m[0m instance_metadata_tags      = "disabled" [90m-> null[0m[0m
        }

      [31m-[0m[0m private_dns_name_options {
          [31m-[0m[0m enable_resource_name_dns_a_record    = false [90m-> null[0m[0m
          [31m-[0m[0m enable_resource_name_dns_aaaa_record = false [90m-> null[0m[0m
          [31m-[0m[0m hostname_type                        = "ip-name" [90m-> null[0m[0m
        }

      [31m-[0m[0m root_block_device {
          [31m-[0m[0m delete_on_termination = true [90m-> null[0m[0m
          [31m-[0m[0m device_name           = "/dev/xvda" [90m-> null[0m[0m
          [31m-[0m[0m encrypted             = false [90m-> null[0m[0m
          [31m-[0m[0m iops                  = 3000 [90m-> null[0m[0m
          [31m-[0m[0m tags                  = {} [90m-> null[0m[0m
          [31m-[0m[0m tags_all              = {} [90m-> null[0m[0m
          [31m-[0m[0m throughput            = 125 [90m-> null[0m[0m
          [31m-[0m[0m volume_id             = "vol-0405c370d9b1abf67" [90m-> null[0m[0m
          [31m-[0m[0m volume_size           = 8 [90m-> null[0m[0m
          [31m-[0m[0m volume_type           = "gp3" [90m-> null[0m[0m
            [90m# (1 unchanged attribute hidden)[0m[0m
        }
    }

[1m  # aws_launch_template.example[0m will be created
[0m  [32m+[0m[0m resource "aws_launch_template" "example" {
      [32m+[0m[0m arn             = (known after apply)
      [32m+[0m[0m default_version = (known after apply)
      [32m+[0m[0m id              = (known after apply)
      [32m+[0m[0m image_id        = "ami-02457590d33d576c3"
      [32m+[0m[0m instance_type   = "t2.micro"
      [32m+[0m[0m latest_version  = (known after apply)
      [32m+[0m[0m name            = (known after apply)
      [32m+[0m[0m name_prefix     = "jenkins-demo-"
      [32m+[0m[0m tags_all        = (known after apply)
      [32m+[0m[0m user_data       = "IyEvYmluL2Jhc2gKc3VkbyBhcHQgdXBkYXRlCnN1ZG8gYXB0IGluc3RhbGwgLXkgbmdpbngKZWNobyAiSGVsbG8gZnJvbSBUZXJyYWZvcm0gd2l0aCBVc2VyIERhdGEhIiA+IC92YXIvd3d3L2h0bWwvaW5kZXguaHRtbAo="

      [32m+[0m[0m metadata_options (known after apply)
    }

[1mPlan:[0m 2 to add, 0 to change, 1 to destroy.
[0m[0m[1maws_instance.myec2: Destroying... [id=i-0947e1d8ccdcef68c][0m[0m
[0m[1maws_launch_template.example: Creating...[0m[0m
[0m[1maws_launch_template.example: Creation complete after 9s [id=lt-0a0ab21bd3fa83d7e][0m
[0m[1maws_autoscaling_group.example: Creating...[0m[0m
[0m[1maws_instance.myec2: Still destroying... [id=i-0947e1d8ccdcef68c, 00m10s elapsed][0m[0m
[0m[1maws_autoscaling_group.example: Still creating... [00m10s elapsed][0m[0m
[0m[1maws_instance.myec2: Still destroying... [id=i-0947e1d8ccdcef68c, 00m20s elapsed][0m[0m
[0m[1maws_autoscaling_group.example: Creation complete after 13s [id=jenkins-asg-demo][0m
[0m[1maws_instance.myec2: Destruction complete after 23s[0m
[0m[1m[32m
Apply complete! Resources: 2 added, 0 changed, 1 destroyed.
[0m
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
✅ ASG deployment successful!
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS


