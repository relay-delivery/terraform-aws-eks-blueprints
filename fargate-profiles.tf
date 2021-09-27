/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

# ---------------------------------------------------------------------------------------------------------------------
# FARGATE PROFILES
# ---------------------------------------------------------------------------------------------------------------------
module "fargate-profiles" {
  //  source = "git@github.com:aws-ia/terraform-aws-eks-fargate.git"
  source = "git@github.com:vara-bonthu/terraform-aws-eks-fargate.git"

  for_each = { for k, v in var.fargate_profiles : k => v if var.enable_fargate && length(var.fargate_profiles) > 0 }

  fargate_profile = each.value

  eks_cluster_name   = module.eks.eks_cluster_id
  private_subnet_ids = var.create_vpc == false ? var.private_subnet_ids : module.vpc.private_subnets

  tags = module.eks-label.tags

  depends_on = [module.eks, kubernetes_config_map.aws_auth]

}

