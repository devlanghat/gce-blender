import bpy

## blender -b -noaudio -o /home/langhatm_gmail_com/gym1-3_image_###### -E CYCLES -P force_gpu.py gym1-3.blend -f 1

def enable_gpus(device_type, use_cpus=False):
    preferences = bpy.context.preferences
    cycles_preferences = preferences.addons["cycles"].preferences
    cuda_devices, opencl_devices = cycles_preferences.get_devices()

    print("CUDA: " + str(cuda_devices))
    print("OpenCL: " + str(opencl_devices))
    if device_type == "CUDA":
        devices = cuda_devices
    elif device_type == "OPENCL":
        devices = opencl_devices
    else:
        raise RuntimeError("Unsupported device type")

    activated_gpus = []

    for device in devices:
        if device.type == "CPU":
            if use_cpus:
                device.use = True
            else:
                device.use = False
        else:
            device.use = True
            activated_gpus.append(device.name)

    cycles_preferences.compute_device_type = device_type
    bpy.context.scene.cycles.device = "GPU"
    print("Activated: " + str(activated_gpus))

    return activated_gpus

enable_gpus("CUDA")
