<script lang="ts" setup>
/// <reference path="../../cloudinary.d.ts" />
import {Cloudinary, type CloudinaryImage} from "@cloudinary/url-gen";

import { ref } from 'vue'
import { Button } from '@/components/ui/button'
import { ImagePlus } from 'lucide-vue-next'
import { useToast } from '@/components/ui/toast/use-toast'
import { Image } from '@/types/common.ts'

const cloudName = process.env.VIDASH_CLOUDINARY_NAME
const uploadPreset = process.env.VIDASH_CLOUDINARY_PRESET

const cld = new Cloudinary({cloud: {cloudName: cloudName,},})

const cloudinaryImage = ref<CloudinaryImage>()
const publicImage = ref<Image>()
const { toast } = useToast()

defineProps<{
  msg?: string
}>()

const emit = defineEmits(["image-uploaded"])

// Remove the comments from the code below to add
// additional functionality.
// Note that these are only a few examples, to see
// the full list of possible parameters that you
// can add see:
//   https://cloudinary.com/documentation/upload_widget_reference

const cloudWidget = cloudinary?.createUploadWidget(
  {
    cloudName: cloudName,
    uploadPreset: uploadPreset,
    resourceType: "image",
    // cropping: true, //add a cropping step
    // showAdvancedOptions: true,  //add advanced options (public_id and tag)
    // sources: [ "local", "url"], // restrict the upload sources to URL and local files
    multiple: false,  //restrict upload to a single file
    // folder: "user_images", //upload files to the specified folder
    // tags: ["users", "profile"], //add the given tags to the uploaded files
    // context: {alt: "user_uploaded"}, //add the given context data to the uploaded files
    // clientAllowedFormats: ["images"], //restrict uploading to image files only
    // maxImageFileSize: 2000000,  //restrict file size to less than 2MB
    // maxImageWidth: 2000, //Scales the image down to a width of 2000 pixels before uploading
    // theme: "purple", //change to a purple theme
  },
  (error: any, result: { event: string; info: any; }) => {
    if (!error && result && result.event === "success") {
      console.log('Done! Here is the image info: ', result.info);
      publicImage.value = {
        public_id: result.info.public_id,
        width: result.info.width,
        height: result.info.height,
        secure_url: result.info.secure_url,
      }
      cloudinaryImage.value = cld.image(result.info.public_id)
      emit("image-uploaded", cloudinaryImage.value)
      toast({
        title: 'Image uploaded successfully',
        description: '1 credit was deducted from your account',
        duration: 5000,
      })
    }
  }
);

const open = () => {
  cloudWidget.open();
}
</script>

<template>
  <div class="w-full">
    <p class="text-lg">Original</p>

    <div v-if="publicImage?.secure_url">
      <img :src="publicImage.secure_url" alt="original"/>
    </div>

    <div
      v-else
      class="mt-2 py-4 grid place-items-center border-dashed border-2 rounded-md
      h-[150px] border-secondary"
    >
      <ImagePlus />
      <Button variant="outline" @click="open">Upload Image</Button>
    </div>
  </div>
</template>
