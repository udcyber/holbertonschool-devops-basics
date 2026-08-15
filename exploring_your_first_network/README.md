# Exploring Your First Network

---

# Introduction and Context

Network activity is usually invisible during everyday computer use. A computer selects an interface, uses local and remote addresses, consults routing information, resolves hostnames, communicates with nearby devices, and opens or listens on network sockets without requiring the user to inspect those operations directly.

In this project, you will observe those operations in a Linux sandbox. You will create small Bash scripts that display network information or perform one focused network check. Each task asks for an observable result but does not prescribe the exact command or options. You are expected to consult the provided documentation, select the appropriate utility, test your script, and compare its output with the task requirements.

The project focuses on using existing Linux networking tools, not on advanced Bash programming. Standard pipelines and simple filtering are allowed when needed, but avoid unnecessary parsing or reformatting when a utility can already produce the required result.

The correction environment is volatile. Interface names, IP addresses, MAC addresses, routes, neighbor entries, and listening ports may change. Your scripts must inspect the current environment and must not contain hardcoded network values.

# Learning Objectives

By the end of this project, students should be able to:

- Identify network interfaces and interpret their operational state and assigned addresses.
- Distinguish link-layer information from IPv4 and IPv6 addressing information.
- Test the IPv4 loopback interface with a fixed number of ICMP echo requests.
- Identify the configured default IPv4 route without assuming a specific gateway or interface.
- Query the operating system's configured hostname-resolution mechanism.
- Inspect the current IPv4 neighbor table.
- Identify listening TCP sockets using numeric addresses and ports.
- Select suitable Linux networking utilities and options from official documentation.
- Explain the roles of loopback, private addressing, IPv6, default routes, hostname resolution, neighbor discovery, and listening sockets.

# General Requirements

- You may use any repository. Place all project files inside a directory named exploring_your_first_network.
- You should include a README.md file inside the project directory.
- Create only the files required by the tasks.
- Every script must:
    - start with ```#!/usr/bin/env bash```;
    - be executable;
    - use UTF-8 encoding;
    - end with a newline;
    - run without requiring administrator or root privileges.
- You may use standard Bash conditionals, positional parameters, pipelines, and common text-processing utilities when necessary.
- Prefer the native output of the selected networking utility. Do not add labels, headings, explanations, or decorative output unless the task explicitly requires them.
- Do not hardcode interface names, IP addresses, IPv6 addresses, MAC addresses, gateways, hostnames, neighbor entries, or port numbers, except for the standard loopback address explicitly provided in its task.
- Do not modify interface configuration, routes, DNS settings, hostname databases, firewall rules, or listening services.
- Do not install packages or use external libraries.
- Do not contact external HTTP APIs.
- The correction environment may contain zero, one, or multiple default routes, neighbor entries, IPv6 addresses, and listening sockets.
- The checker executes a reference solution in the same environment and compares the relevant output. Dynamic values such as latency, elapsed time, neighbor state, and spacing may be normalized by the checker when the task states that they can vary.
- The checker may inspect file existence, executable permissions, shebangs, exit status, standard output, and unexpected standard error.
- Students must be able to explain and modify every submitted script, regardless of which tools were used while working on the project.

---

## 0. List Network Interfaces

Objective:

Display a concise overview of every network interface and its assigned addresses.

Instructions:

Create a Bash script that displays a brief summary of all network interfaces available in the current environment.

For each interface, the result must show:

- the interface name;
- its operational state;
- its assigned IPv4 and IPv6 addresses, when present.

Preserve the brief tabular format and ordering produced by the selected Linux networking utility. Include the loopback interface and interfaces that do not have an assigned address.

Input:

Not applicable.

Output:

The complete brief interface-address table produced for the current environment. Do not add any text before or after the table.

Expected result:

The script reports every interface that exists when it is executed. Values may differ between environments.

Constraints:

- Do not hardcode interface names, states, or addresses.
- Do not remove the loopback interface.
- Do not sort or reformat the utility's output.

Files:

- `list_interfaces.sh`
Example output:
```
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0@if5         UP             169.254.172.2/22 fe60::f003:dcaf:fe31:3e72/64
eth1             UP             10.42.125.74/16 fe80::46b:71ff:fafd:a2a5/64
```
This is an example only. Interface names, states, addresses, and the number of lines will differ between environments.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: list_interfaces.sh  

---

## 1. Inspect Network Links

Objective:

Display link-layer information and identify the hardware address associated with each network interface.

Instructions:

Create a Bash script that displays brief link-layer information for every network interface.

For each interface, the result must include:

- the interface name;
- its operational state;
- its link-layer address when available;
- its interface flags.

Preserve the brief tabular format and ordering produced by the selected Linux networking utility.

Input:

Not applicable.

Output:

The complete brief link table for the current environment. Do not add labels or explanations.

Expected result:

The script shows link-layer information for all interfaces, including loopback.

Constraints:

- Do not hardcode interface names, states, link-layer addresses, or flags.
- Do not remove interfaces from the result.
- Do not sort or reformat the utility's output.

Files:

- `show_links.sh`

Example output:
```
lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
eth0@if5         UP             f2:03:da:51:3e:72 <BROADCAST,MULTICAST,UP,LOWER_UP>
eth1             UP             06:7b:70:fa:a2:c5 <BROADCAST,MULTICAST,UP,LOWER_UP>
```
This is an example only. Link-layer addresses and flags will differ between environments.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: show_links.sh  

---

## 2. Test the IPv4 Loopback Interface

Objective:

Discover an IPv4 loopback address from the current system configuration and use it to test the local network stack.

Instructions:

Create a Bash script that:

1. Lists the IPv4 addresses whose scope is limited to the local host.
2. Selects the first address shown.
3. Removes its CIDR prefix.
4. Sends exactly four ICMP echo requests to the resulting IPv4 address.
5. Displays the complete output produced by the connectivity test.

The loopback interface name and address must be discovered from the current system configuration. They must not be hardcoded.

Your solution must contain a single command line after the shebang. You may combine several commands using pipes and command substitution.

Input:

The IPv4 interface configuration of the execution environment.

No command-line arguments are required.

Output:

The complete output of four ICMP echo requests sent to the discovered host-scoped IPv4 address.

Expected result:

The selected address responds through the local network stack. The output includes four transmitted packets, the responses received, packet-loss information, and timing statistics.

Timing values may differ between executions.

Constraints:

- Discover the address from the current system configuration.
- Select the first IPv4 address with host scope.
- Do not assume that the interface is named lo.
- Do not hardcode 127.0.0.1 or another loopback address.
- Remove the CIDR prefix before using the address.
- Send exactly four ICMP echo requests.
- Preserve the complete output of the connectivity-testing utility.
- Do not use awk or sed.
- Do not add labels or explanatory text.
- The script must contain exactly one command line after the shebang.

Files:

- `test_loopback.sh`

Example:

The following output is only an example. The selected address and timing values may differ:
```
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.030 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.035 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.033 ms
64 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.029 ms

--- 127.0.0.1 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3070ms
rtt min/avg/max/mdev = 0.029/0.031/0.035/0.002 ms
```
Hints:

- In Linux networking, every IP address is assigned a scope, which defines where that address is valid and reachable.
- The ip command can display this scope information; for example, scope host indicates that an address is valid only within the local machine.
- The loopback IPv4 address belongs to the host scope, meaning it never leaves the local network stack and is used for internal communication within the system.
- Using scope host ensures that you reliably select loopback-related addresses without assuming interface names (such as lo) or fixed IP values (such as 127.0.0.1).
- A brief address listing presents the interface, state, and assigned address in columns.
- Consecutive spaces may need to be reduced before selecting one column.
- The selected address includes a CIDR prefix that must be removed.
- Command substitution allows the output of one pipeline to become an argument of another command.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: test_loopback.sh  

---

## 3. Show the Default IPv4 Route

Objective:

Inspect the route or routes used for IPv4 destinations that do not match a more specific route.

Instructions:

Create a Bash script that displays every configured default IPv4 route.

Preserve the complete output and ordering produced by the selected routing utility.

If the environment has no default IPv4 route, the script must produce no standard output and still exit successfully.

Input:

Not applicable.

Output:

Zero or more default IPv4 route lines. Do not add labels, headings, or fallback messages.

Expected result:

The script reflects the current routing configuration without assuming a particular gateway, interface, metric, or number of routes.

Constraints:

- Include IPv4 default routes only.
- Do not hardcode gateway addresses or interface names.
- Do not extract or reformat individual route fields.

Files:

- `show_default_route.sh`

Example output:
```
default via 10.42.0.1 dev eth1
```
This is an example only. A valid environment may produce no output, one route, or multiple default routes with additional attributes.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: show_default_route.sh  

---

## 4. Resolve a Hostname Through the System Database

Objective:

Use the operating system's configured hostname-resolution mechanism to retrieve host information.

Instructions:

Create a Bash script that receives exactly one hostname as its first positional argument and queries the system host database for that hostname.

Print the complete result returned by the host database lookup. Do not add, remove, reorder, or reformat entries.

Input:

One hostname supplied as the first positional argument.

Example invocation:
```
./resolve_hostname.sh www.example.com
```
Output:

The complete host-database result for the supplied hostname, with no additional text.

Expected result:

The output may contain an IPv4 address, an IPv6 address, one or more aliases, or multiple lines, depending on the environment's Name Service Switch configuration.

Constraints:

- Use the system host database rather than an external HTTP service.
- Do not hardcode the hostname or expected addresses.
- Preserve all returned entries and their original ordering.
- Input validation beyond the stated checker conditions is out of scope.

Files:

- `resolve_hostname.sh`

Example output:
```
::1             localhost ip6-localhost ip6-loopback
```
This is an example only. The addresses, aliases, number of lines, and order depend on the environment's hostname databases and Name Service Switch configuration.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: resolve_hostname.sh  

---

## 5. Display the IPv4 Neighbor Table

Objective:

Inspect the operating system's current IPv4 neighbor information.

Instructions:

Create a Bash script that displays the complete current IPv4 neighbor table.

Preserve the format and ordering produced by the selected networking utility. Do not generate additional traffic before reading the table.

The table may be empty. An empty result is valid and must not be treated as an error.

Input:

Not applicable.

Output:

Zero or more IPv4 neighbor entries, with no added text.

Expected result:

Entries may contain an IPv4 address, interface name, link-layer address, router marker, and neighbor state. The exact contents depend on recent activity in the environment.

Constraints:

- Include IPv4 neighbors only.
- Do not hardcode addresses, interfaces, MAC addresses, or states.
- Do not send traffic to populate or refresh the table.
- Do not remove incomplete or failed entries.

Files:

- `show_neighbors.sh`

Example output:
```
10.42.0.1 dev eth1 lladdr 06:94:f5:0a:57:9c REACHABLE
```
This is an example only. The table may contain no entries or several entries, and states such as REACHABLE or STALE may change between executions.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: show_neighbors.sh  

---

## 6. List Listening TCP Sockets

Objective:

Inspect TCP sockets that are currently waiting for incoming connections.

Instructions:

Create a Bash script that displays all listening TCP sockets using numeric addresses and numeric port numbers.

The output must:

- include the table header generated by the selected socket-inspection utility;
- include listening TCP sockets only;
- use numeric addresses and numeric ports;
- omit process information.

Preserve the output format and ordering produced by the selected utility.

Input:

Not applicable.

Output:

A table containing the header and every listening TCP socket present when the script runs.

Expected result:

The result may contain IPv4 sockets, IPv6 sockets, loopback bindings, wildcard bindings, or no data rows beyond the header.

Constraints:

- Do not include UDP sockets.
- Do not resolve addresses or service names.
- Do not display process names or process identifiers.
- Do not hardcode expected ports.
- Do not sort or reformat the table.

Files:

- `list_listening_tcp.sh`

Example output:
```
State  Recv-Q Send-Q Local Address:Port Peer Address:Port
LISTEN 0      4096         0.0.0.0:1384      0.0.0.0:*
LISTEN 0      4096            [::]:1384         [::]:*
```
This is an example only. Socket addresses, ports, queue values, spacing, and the number of rows depend on the environment.

Repo:

GitHub repository: holbertonschool-devops-basics  
Directory: exploring_your_first_network  
File: list_listening_tcp.sh  
