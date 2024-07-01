{
    services = {
        # Enable mounting service.
        udisks2.enable = true;

        # Enable trash service.
        gvfs.enable = true;
        tumbler.enable = true;
    };

    systemd.services = {
        # TODO: Move these to this-device config
        # # USB Keyboard/Mouse sleeping fix
        noUsbSleep = {
            enable = true;
            wantedBy = ["multi-user.target"];
            script = ''
                sleep 30
                echo on | tee /sys/bus/usb/devices/*/power/level > /dev/null
            '';
        };
    };
}
