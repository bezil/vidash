<script lang="ts" setup>
import { AdvancedImage } from '@cloudinary/vue'
import { type CloudinaryImage } from "@cloudinary/url-gen"
import { generativeRestore } from "@cloudinary/url-gen/actions/effect"
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { ref } from "vue"
import { Input } from '@/components/ui/input'
import { Separator } from 'radix-vue'
import { Button } from '@/components/ui/button'
import UploaderForm from "@/components/form/UploaderForm.vue"
import { Skeleton } from '@/components/ui/skeleton'

const cloudinaryImage = ref<CloudinaryImage>()
const transformedImage = ref<CloudinaryImage>()
const transformedImageURL = ref('')
const isTransposing = ref(false)

const setImageInformation = (uploadedImage: CloudinaryImage) => {
  cloudinaryImage.value = uploadedImage
}


const applyRestore = () => {
  if (!cloudinaryImage.value) {
    return
  }

  transformedImage.value = cloudinaryImage.value
    .effect(generativeRestore())
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
    <UploaderForm
      @image-uploaded="setImageInformation($event)"
    />

      <Button
        :disabled="!cloudinaryImage"
        @click="applyRestore()"
      >Restore Image</Button>

      <Separator />

<template v-if="transformedImageURL">

  <span class="text-lg">Transposed Image</span>
  <Skeleton v-if="!isTransposing" class="h-[125px] w-full rounded-xl" />
  <AdvancedImage v-show="isTransposing" :cld-img="transformedImage" @load="isTransposing = true"/>
  <Button class="mb-4" variant="secondary">Save Image</Button>
</template>
    </div>
</template>
