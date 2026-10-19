# AWS VPC Peering Project
Name-Madhav Aggarwal
Batch-1
Completion Date-29 October, 2026

## Project overview
This project demonstrates private network connectivity between two Amazon VPCs using VPC Peering.

**Configuration**
- Region: Asia Pacific (Mumbai), `ap-south-1`
- VPC A: `10.10.0.0/16`
- VPC B: `10.20.0.0/16`
- VPC A public subnet: `10.10.1.0/24`
- VPC A private subnet: `10.10.2.0/24`
- VPC B private subnet: `10.20.1.0/24`
- Bastion host planned private address: `10.10.1.10`
- App-A planned private address: `10.10.2.10`
- App-B planned private address: `10.20.1.10`

## Package contents
- `REPORT.md` — report draft with design, implementation, validation, and conclusion
- `architecture.svg` — project architecture diagram
- `evidence/` — AWS console layouts and terminal output layouts
- `scripts/` — helper commands for testing after the real instances are configured

## Using the visuals
The files in `evidence/` show the intended configuration and connectivity output patterns.

## High-level implementation
1. Select the intended region in the AWS console.
2. Create VPC A and VPC B with the CIDR ranges above.
3. Create the three subnets.
4. Configure internet access only where needed for the bastion host; do not expose application instances publicly.
5. Launch the instances and record their private IP addresses.
6. Create a VPC peering connection between the two VPCs and accept it.
7. Add reciprocal routes to the peer CIDR in the relevant route tables.
8. Configure security groups and host firewalls to permit only the required traffic.
9. Test connectivity in both directions and capture genuine evidence.
10. Clean up billable resources when finished.
