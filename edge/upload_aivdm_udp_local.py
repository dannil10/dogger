import gateway.uplink


udp_upload_ais = gateway.uplink.UdpAivdmPosition(
    channels = {61011,61012}, 
    start_delay = 0,
    port = 4444,
    max_age = 10,
    mmsi = 123456789,
    vessel_name = "L01 VW CRAFTER", 
    call_sign = "FJJ976", 
    ship_type = 90,
    config_filepath = '/home/heta/Z/app/python/dogger/', 
    config_filename = 'conf_udp_local.ini')

udp_upload_ais.run()