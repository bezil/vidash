<script lang="ts" setup>
import { AdvancedImage } from '@cloudinary/vue'
import { type CloudinaryImage } from "@cloudinary/url-gen"
import { ref } from "vue"
import { generativeRemove } from "@cloudinary/url-gen/actions/effect"
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
const prompt = ref('')

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
const updatePrompt = (item: string | number) => {
  prompt.value = item.toString()
}

const applyRemoval = () => {
  if (!cloudinaryImage.value || !prompt.value) {
    return
  }

  transformedImage.value = cloudinaryImage.value
    .effect(generativeRemove().prompt(prompt.value))
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

      <FormField v-slot="{ componentField }" name="name">
        <FormItem>
            <FormLabel>Enter object to remove</FormLabel>
            <FormControl>
            <Input
              type="text" placeholder="Input prompt for remove" v-bind="componentField"
              @update:model-value="updatePrompt($event)"
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
      :disabled="!cloudinaryImage || !prompt"
      @click="applyRemoval()"
      >Remove Object</Button>

      <Separator />

<template v-if="transformedImageURL">

  <span class="text-lg">Transposed Image</span>
  <Skeleton v-if="!isTransposing" class="h-[125px] w-full rounded-xl" />
  <AdvancedImage v-show="isTransposing" :cld-img="transformedImage" @load="isTransposing = true"/>
  <Button class="mb-4" variant="secondary" @click=saveImage()>Save Image</Button>
</template>
    </div>
</template>
