# AWS IAM Policy Terraform module

This is AWS IAM Policy module for Terraform v0.12 and above. It uses Dynamic Nested Blocks, which are not supported by earlier versions of Terraform.
It aims to create both `aws_iam_policy` resource and `aws_iam_policy_document` data blocks.

## Usage

Usage of this module is quite straightforward. It accepts most of the inputs of resource `aws_iam_policy`.
Instead of `policy` input, it takes a required argument `statemests`, which is a list of maps similar to `statement` from `aws_iam_policy_document` data source.
In general, it's easier to show than describe, so here's a basic example:

    module "grafana_policy" {
      source      = "grodzik/iam_policy/aws"
      description = "Provides read-only access for grafana user"
      name        = "grafana-ro-access"
      path        = "/"
      statements = [
        {
          sid = "GrafanaEC2AccessRO"
          actions = [
            "ec2:DescribeTags",
            "ec2:DescribeRegions",
            "ec2:DescribeInstances",
          ]
          effect    = "Allow"
          resources = ["*"]
        }
      ]
    }

The code above will create both `aws_iam_policy` resource and `aws_iam_policy_document` data resource.
The advantage of this is that whole definition in a single block. It's easier to read and manage, for example move inside the state file.
`condition` and `principals` are also supported.

### condition block

`condition` is a block which should look like this:

    ...
    statements = [
        ...
        condition = [
            {
                test = "StringEquals"
                variable = "s3:x-amz-acl"
                values = [
                    "public-read"
                ]
            }
        ]
    ]

which is equal to:

      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": [
            "public-read"
          ]
        }
      }

### principals block

`principals` is a block which should look like this:

    ...
    statements = [
        ...
        principals = [
            {
                type = "AWS"
                identifiers = "arn:aws:iam::AccountNumber-WithoutHyphens:root"
            }
        ]
    ]

which is equal to this:

    "Principal":{
        "AWS": "arn:aws:iam::AccountNumber-WithoutHyphens:root"
    }

## LIMITATIONS

There is one limitation to this, enforced by Terraform itself. All the `statements` need to have equal number of items with same type. If you want to have a `condition` block in one of the `statements`, then you need to add `condition = []` to all other `statements`:

    module "bucket_access" {
      source      = "grodzik/iam_policy/aws"
      description = "Provides access to my-bucket"
      name        = "my-bucket-access"
      path        = "/"
      statements = [
        {
          sid = "MyBucketRoAccess"
          actions = [
            "s3:DescribeBuckets",
            "s3:ListBuckets",
            "s3:GetObject",
            "s3:GetObjectV2"
          ]
          effect    = "Allow"
          resources = [
             "arn:aws:s3:::my-bucket/*"
          ]
          condition = []
        },
        {
          sid = "MyBucketRWAccess"
          actions = [
            "s3:PutObject"
          ]
          effect    = "Allow"
          resources = [
             "arn:aws:s3:::my-bucket/*"
          ]
          condition = [
              {
                  test = "StringEquals"
                  variable = "s3:x-amz-acl"
                  values = [
                    "public-read"
                  ]
              }
          ]
        }
      ]
    }
