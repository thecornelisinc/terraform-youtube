# Deploying 3-tier architecture application in terraform

Steps:
#  Networking Deployment
1. Create the architecture diagram - done
2. Create the VPC - done
3. create the internet gateway - done
4. create 2 public subnet and 4 private subnets and add two of them as a database subnet group - done
5. create 1 public route-table done
6. create routes to internet gateway on the public route-table done
7. Associate the public route-table to  all public subnets - done
8. create 4 private route-table - done
9. Associate 4 private route-tables to  each of the private subnets - done
10. Create a Nat gateway for the private subnet - done
11. Create route to the nat gateway on the route-table associated to each of the private subnets - done
12. Create route to the internet on the route-table associated to each of the private subnets - done

# Presentation Layer deployment
13. Create 2 instances in 2 different public subnets done
14. create a target group and attached the 2 instances to the target group. Route traffic to the target group on port 80.
15. Create a Load Balancer  and linked it to the target group.

# Application Layer Deployment

16. Create 2 instances in 2 different private subnets done
17. create a target group and attached the 2 instances to the target group. Route traffic to the target group on port 80.
18. Create a Load Balancer  and linked it to the target group.

# Database layer Deployment

19. Create a RDS with MySQL Database. Use Secret Manager to store the Database credentials.
