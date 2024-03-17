<script lang="ts" setup>
import { ref } from 'vue'
import { type CloudinaryImage } from "@cloudinary/url-gen"
import { backgroundRemoval } from "@cloudinary/url-gen/actions/effect"
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { Separator } from 'radix-vue'
import { Button } from '@/components/ui/button'
import UploaderForm from '@/components/form/UploaderForm.vue'
import { Skeleton } from '@/components/ui/skeleton'

const cloudinaryImage = ref<CloudinaryImage>()
const transformedImage = ref<CloudinaryImage>()
const transformedImageURL = ref('')
const isTransposing = ref(false)

const emit = defineEmits(['image-saved'])

const saveImage = () => {
  emit('image-saved', {
    old: cloudinaryImage,
    new: transformedImage,
  })
}


const setImageInformation = (uploadedImage: CloudinaryImage) => {
  cloudinaryImage.value = uploadedImage
}

const applyBgRemove = () => {
  if (!cloudinaryImage.value) {
    return
  }

  transformedImage.value = cloudinaryImage.value
    .effect(backgroundRemoval())
  transformedImageURL.value = transformedImage.value.toURL()

  console.log(transformedImageURL.value)
}
</script>
<template>
    <div class="flex flex-col gap-4 focus:ring-0 ">
        <FormField v-slot="{ componentField }" name="name">
        <FormItem>
            <FormLabel>Image name</FormLabel>
            <FormControl>
            <Input
              type="text" placeholder="Input name for Image" v-bind="componentField"
            />
            </FormControl>
            <FormMessage />
        </FormItem>
      </FormField>

    <Separator />

    <UploaderForm @image-uploaded="setImageInformation($event)" />

      <Button
      :disabled="!cloudinaryImage"
      @click="applyBgRemove()"
      >Remove Background</Button>


      <Separator />

<template v-if="transformedImageURL">

  <span class="text-lg">Transposed Image</span>
  <Skeleton v-if="!isTransposing" class="h-[125px] w-full rounded-xl" />
  <img v-show="isTransposing" :src="transformedImageURL" @load="isTransposing = true"/>
  <Button class="mb-4" variant="secondary" @click=saveImage()>Save Image</Button>
</template>
    </div>
</template>
