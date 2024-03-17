<script lang="ts" setup>
import { AdvancedImage } from '@cloudinary/vue'
import { type CloudinaryImage } from "@cloudinary/url-gen"
import { generativeRecolor } from "@cloudinary/url-gen/actions/effect"
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
import { ref } from 'vue'
import PickColors from 'vue-pick-colors'
import { useDark } from '@vueuse/core'
import UploaderForm from '@/components/form/UploaderForm.vue'
import { Skeleton } from '@/components/ui/skeleton'

const isDark = useDark()

const color = ref('#FF0000')

const cloudinaryImage = ref<CloudinaryImage>()
const transformedImage = ref<CloudinaryImage>()
const transformedImageURL = ref('')
const isTransposing = ref(false)
const object = ref('')

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
const updateObjectToRemove = (item: string | number) => {
  object.value = item.toString()
}

const applyRecolor = () => {
  if (!cloudinaryImage.value || !object.value) {
    return
  }

  transformedImage.value = cloudinaryImage.value
    .effect(generativeRecolor(object.value, color.value.substring(1)))
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
          <Input type="text" placeholder="Input name for Image" v-bind="componentField" />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="name">
      <FormItem>
        <FormLabel>Object to recolor</FormLabel>
        <FormControl>
          <Input
            type="text" placeholder="Input item name to recolor" v-bind="componentField"
            @update:model-value="updateObjectToRemove($event)"
          />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <div class="flex flex-row items-center">
      <span class="text-sm">Choose color to recolor with : <b>{{ color }}</b></span>

      <pick-colors v-model:value="color" :theme="isDark ? 'dark' : 'light'" format="hex" class="cursor-pointer" />
    </div>

    <Separator />
    <UploaderForm @image-uploaded="setImageInformation($event)" />

    <Button
      :disabled="!cloudinaryImage || !object"
      @click="applyRecolor()"
    >Recolor Object</Button>

    <Separator />

    <template v-if="transformedImageURL">

      <span class="text-lg">Transposed Image</span>
      <Skeleton v-if="!isTransposing" class="h-[125px] w-full rounded-xl" />
      <AdvancedImage v-show="isTransposing" :cld-img="transformedImage" @load="isTransposing = true" />
      <Button class="mb-4" variant="secondary" @click=saveImage()>Save Image</Button>
    </template>
  </div>
</template>
