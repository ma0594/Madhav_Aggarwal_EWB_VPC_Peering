# AWS VPC Peering — Project Report
Name-Madhav Aggarwal
Batch-1
Region-Asia Pacific(Mumbai)
Completion Date-29 October, 2026

## 1. Title
Implementation and Connectivity Verification of AWS VPC Peering

## 2. Objective
To design two isolated Amazon Virtual Private Clouds (VPCs), connect them through VPC Peering, configure routing and security rules, and verify private IP connectivity between application instances.

## 3. Proposed network design

| Component | CIDR / private IP |
|---|---|
| VPC A | `10.10.0.0/16` |
| VPC A public subnet | `10.10.1.0/24` |
| VPC A private subnet | `10.10.2.0/24` |
| Bastion host (planned) | `10.10.1.10` |
| App-A (planned) | `10.10.2.10` |
| VPC B | `10.20.0.0/16` |
| VPC B private subnet | `10.20.1.0/24` |
| App-B (planned) | `10.20.1.10` |
| AWS region | Mumbai (`ap-south-1`) |

The IP addresses listed for instances are planned addresses. Record the actual assigned addresses in the final deployment report.

## 4. Architecture
VPC A contains a public subnet for a bastion host and a private subnet for App-A. VPC B contains a private subnet for App-B. A VPC peering connection links the two VPCs. Route tables in both VPCs must include routes to the other VPC's CIDR, using the same peering connection as the target.

## 5. Routing requirements

| Route table | Destination | Target |
|---|---|---|
| VPC A route table | `10.10.0.0/16` | `local` |
| VPC A route table | `10.20.0.0/16` | Actual VPC peering connection |
| VPC B route table | `10.20.0.0/16` | `local` |
| VPC B route table | `10.10.0.0/16` | Actual VPC peering connection |

The VPC peering connection must be accepted and in the `Active` state. Confirm the routes are associated with the route tables used by the relevant subnets.

## 6. Security considerations
- Permit SSH to the bastion only from an appropriate trusted source IP.
- Permit SSH from the bastion to private instances only as required.
- For ping validation, permit ICMP echo request/reply traffic between the intended private addresses or CIDR ranges.
- Do not expose private application instances directly to the public internet.
- Review network ACLs and instance-level firewalls if connectivity tests fail.

## 7. Implementation procedure
1. Create VPC A and VPC B in the same intended AWS region.
2. Create the subnets using the CIDR ranges in Section 3.
3. Configure the bastion's public access, internet gateway, and public route table as required.
4. Launch App-A and App-B in their private subnets and record their actual private IPs.
5. Create and accept the VPC peering connection.
6. Add the reciprocal VPC routes shown in Section 5.
7. Configure security groups and operating-system firewalls for the intended test traffic.
8. Connect to the private instances through an approved access method.
9. Run the tests below and capture the output.

## 8. Validation commands
From App-A, test App-B:
```bash
ping -c 4 10.20.1.10
```
From App-B, test App-A:
```bash
ping -c 4 10.10.2.10
```

A successful ping typically shows received replies and low or zero packet loss. A failed ping may indicate a missing route, security-group rule, network ACL rule, host firewall rule, incorrect IP, or unavailable instance. Ping output alone does not identify the root cause.

## 9. Results and evidence
Attach screenshots from the AWS console showing:
- Both VPCs and subnet CIDRs
- Peering connection in `Active` state
- Reciprocal route entries
- Relevant security-group rules
- Actual ping output in both directions

## 10. Conclusion
VPC Peering enables private IP communication between the two VPCs when the peering connection is active, routes are correctly configured in both directions, and security controls permit the traffic. Successful validation must be demonstrated with tests run against the actual deployed instances.

## 11. Cleanup
After collecting evidence, terminate test EC2 instances and remove unneeded resources, including any unused public IPv4 addresses, peering connections, NAT gateways, or other billable resources. Confirm current AWS pricing before deployment and cleanup.
