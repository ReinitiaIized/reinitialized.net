#VLANs

## Infrastructure
10: management (10.10.0.0/16)
  ESXi Hosts (10.10.0.0/22)
    Cluster alpha (10.10.0.0/23) 
      Compute (10.10.0.0/24)
      - 10.10.0.1   c1.a (future R820)
      - 10.10.0.2   c2.a (future R820)

      Storage Nodes (10.10.1.0/24)
      - 10.10.1.1   vs1.a (R720)
      - 10.10.1.2   vs2.a (R720)
      - 10.10.1.3   vs3.a (R720)

    Cluster bravo (10.10.2.0/23)
      Management (10.10.2.0/24)
      - 10.10.2.1   m1.b (future R320)

      Game Server (10.10.3.0/24)
      - 10.10.3.1   gs1.b (old gaming laptop)  

  iDRAC (10.10.4.0/22)
    Cluster alpha (10.10.4.0/23)
      - 10.10.4.1   c1a-lom
      - 10.10.4.2   c2a-lom
      - 10.10.5.1   vs1a-lom
      - 10.10.5.2   vs2a-lom
      - 10.10.5.3   vs3a-lom
    
    Cluster bravo (10.10.6.0/23)
      - 10.10.6.1   gs1b-lom

  Infrastructure Hardware (10.10.8.0/23)
    Switches (10.10.8.0/24)
      Core Switches
      - 10.10.8.1   csw1.sw (48 port)
      
      Server Switches
      - 10.10.8.2   ssw1.sw (24 port)
      
      Other Switches
      - 10.10.8.10  os1.sw (5 port)

      WAPs (10.10.9.0/24)
      - 10.10.9.1   east.waps
      - 10.10.9.2   west.waps
      - 10.10.9.3   outside.waps
    
  Services (10.10.10.0/24)
    - 10.10.10.1   vc.ms
    - 10.10.10.10  unifi.ms

11: vsan    (192.168.11.0/24)
  vSAN Hosts 
    - 192.168.11.1   vs1.a
    - 192.168.11.2   vs2.a
    - 192.168.11.3   vs3.a

12: internal    (10.12.0.0/16)
  vMotion
    - 10.12.0.1   vs1.a
    - 10.12.0.2   vs2.a
    - 10.12.0.3   vs3.a
    - 10.12.0.4   m1.b
  
  Provisioning
    - 10.12.1.1   vs1.a
    - 10.12.1.2   vs2.a
    - 10.12.1.3   vs3.a
    - 10.12.1.4   m1.b

  Other Internal Host Services
    - 10.12.2.1   vs1.a
    - 10.12.2.2   vs2.a
    - 10.12.2.3   vs3.a
    - 10.12.2.4   m1.b

## Services
30: iservices (10.30.0.0/16) internal-services
  Core (10.30.0.1/24)
  - 10.30.0.1   dns1 (Pi-Hole)
  - 10.30.0.2   dns2 (Pi-Hole)
  - 10.30.0.3   vpn.home (Wireguard)
  - 10.30.0.4   vpn.esvcs (External Services Wireguard)

    Rancher 
    - 10.30.0.20
    - 10.30.0.21
    - 10.30.0.22 

31: eservices    (10.31.0.0/16) exposed-services
  Core Services
    - 10.31.0.1   vpn.home   (Wireguard)
    - 10.31.0.2   vpn.esvcs (External Services Wireguard)

## Residential
50: devices    (10.50.0.0/16)
51: insecure    (10.51.0.0/16)
52: guest    (10.52.0.0/16)

## Other
200: testing    (10.200.0.0/16)