import gateway.daqc


screenshot = gateway.daqc.ScreenshotUpload(
    channels = {600}, 
    sample_rate = 1.0, 
    crop = [0,184,1243,1040], 
    video_quality = 80, 
    config_filepath = 'C:\\screenshot\\',
    config_filename = 'conf_local.ini')

screenshot.run()