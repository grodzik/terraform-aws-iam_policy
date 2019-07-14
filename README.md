# AWS IAM Policy Terraform module

This is AWS IAM Policy module for Terraform v0.12 and above. It uses Dynamic Nested Blocks, which are not supported by earlier versions of Terraform.
It aims to create both `aws_iam_policy` resource and `aws_iam_policy_document` data blocks.

## Usage

Usage of this module is quite straightforward. It accepts most of the inputs of resource `aws_iam_policy`.
Instead of `policy` input, it takes a required argument `statemests`, which is a list of maps similar to `statement` from `aws_iam_policy_document` data source.
