# Terraform Zero to Hero Training
===================================

# Day 1: Getting Started and Setting Up Labs
    Understanding Infrastructure as Code (IAC)  
    Download, Installation and setup of Work Environment:
        Setup an AWS Account
        Download and Install Terraform 
        Download and Install Text editor(VScode)- Optional
        Install Terraform Extension for VSCode 
        Up and Running with terraform documentation 
        Your first Terraform project

# Day 2: Basic Infrastructure Deployment with Terraform
======================================================
1. Terraform configuration files     
2. Authentication and Authorization in Terraform 
3. Working with providers and resource blocks
4. Basic Terraform Commands(Init, Plan, Apply, Destroy)
   
==================================================================
# Terraform configuration files
1. .tf
2. terraform.tfvars
3. terraform.tfstate- It tracks the current state  of your infrastructure
4. .tfstate.backup
5. .hcl
6. .tfignore

# Day 3: Terraform Folder Structure for 
Terraform Folder Layout
Resources Blocks
Variables Input and Outputs
Project 1: Deploying VPC, Internet Gateway, Subnets and Route-table 

 # Day 4: Leveraging Data Sources, Remote State, Terraform Locking, and Git Repositories
    Create and clone Git Repository
    Using data sources to fetch information
    Managing remote state with S3 backends
    Terraform remote state locking

# Day 5: Working with Data
    Creating and using Terraform modules
    Terraform lifecycle
        * create_before_destroy = false

# Day 6: Advanced Terraform Concepts
    Terraform Module
    Terraform Count 
    Terraform For-each

# Day 7: Advanced Terraform Concepts(Part 2)
    Terraform functions 
        String Functions
            lower
            upper
            title
            trimspace
        Numberic Function
            min
            max
            abs
            ceil
            floor 

        Collection Function 
            length

        

# Day 8: Terraform Expression
    Terraform expressions
        - What is Terraform Expression?
        - Why Terraform Expression
        - What Data type can Terraform expression resolved to?
        - Operators
            * Arithmetic Operator
            * Equality Operator  
            * Comparison Operators
            * Logical Operators
        - Basic Terraform Expression
            * Interpolation of Variables into String
        - Mathematical Expression
            * Performing basic math operations 
        - Conditional Expression        
        - Dynamic Blocks Expression



# Day 9: Terraform Import(recorded Video)
    Hands-on project: Deploy a Three-tier application with Terraform
    
# Day 10: Real-World Projects
    Import resources from terraform
    Troubleshooting and debugging Terraform issues
