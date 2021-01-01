# VLANs

## Infrastructure
10: management (10.10.0.0/16)
  ESXi Hosts (10.10.0.0/22)
    Cluster alpha (10.10.0.0/23) 
    - 10.10.0.0   hc1.a (R720)
    - 10.10.0.1   hc2.a (R720)
    - 10.10.0.2   hc3.a (R720)
    - 10.10.0.3   hc4.a (R720) FUTURE DEPLOYMENT

    Cluster bravo (10.10.2.0/23)
      Management (10.10.2.0/24)
      - 10.10.2.0   m1.b (R320) FUTURE DEPLOYMENT

      Game Server (10.10.3.0/24)
      - 10.10.3.0   gs1.b (previous laptop)


  iDRAC (10.10.4.0/22)
    Cluster alpha (10.10.4.0/23)
      - 10.10.4.0   hc1.a.ipmi
      - 10.10.4.1   hc2.a.ipmi
      - 10.10.4.2   hc3.a.ipmi
      - 10.10.4.3   hc4.a.ipmi
    
    Cluster bravo (10.10.6.0/23)
      - 10.10.6.0   m1.b.ipmi

  Infrastructure Hardware (10.10.8.0/23)
    Switches (10.10.8.0/24)
      Core Switches
      - 10.10.8.0   csw1.sw (48 port)
      
      Server Switches
      - 10.10.8.10   ssw1.sw (24 port)
      
      Other Switches
      - 10.10.8.20  os1.sw (5 port)

      WAPs (10.10.9.0/24)
      - 10.10.9.0   east.wap
      - 10.10.9.1   west.wap
      - 10.10.9.2   upstairs.wap
    

  Services (10.10.10.0/24)
    - 10.10.10.0   vc


11: vsan    (192.168.11.0/24)
  vSAN Hosts 
    - 192.168.11.0   hc1.a
    - 192.168.11.1   hc2.a
    - 192.168.11.2   hc3.a
    - 192.168.11.3   hc4.a FUTURE DEPLOYMENT


12: internal    (10.12.0.0/16)
  vMotion
    - 10.12.0.0   hc1.a
    - 10.12.0.1   hc2.a
    - 10.12.0.2   hc3.a
    - 10.12.0.3   hc4.a
    - 10.12.1.0   m1.b
    - 10.12.1.1   gs.b

  Provisioning
    - 10.12.1.0   hc1.a
    - 10.12.1.1   hc2.a
    - 10.12.1.2   hc3.a
    - 10.12.1.3   hc4.a
    - 10.12.1.4   m1.b

  Other Internal Host Services
    - 10.12.2.0   hc1.a
    - 10.12.2.1   hc2.a
    - 10.12.2.2   hc3.a
    - 10.12.2.3   hc4.a
    - 10.12.2.4   m1.b

## Services
30: services (10.30.0.0/16) services
  Core (10.30.0.1/24)
  - 10.30.0.1   cdh1
    - Pi-Hole
    - UniFi
    - WireGuard for Personal

  - 10.30.0.2   chd2
    - Pi-Hole
    - WireGuard for External

## Residential
50: devices    (10.50.0.0/16)
  Gavin
    
  Matthew

  Bethany

  Evan
51: insecure    (10.51.0.0/16)


52: guest    (10.52.0.0/16)

## Other
200: testing    (10.200.0.0/16)