<script lang="ts" setup>
import { AdvancedImage } from '@cloudinary/vue'
import { type CloudinaryImage } from "@cloudinary/url-gen"
import { ref } from "vue"
import { pad } from "@cloudinary/url-gen/actions/resize"
import { generativeFill } from "@cloudinary/url-gen/qualifiers/background"
import UploaderForm from "@/components/form/UploaderForm.vue"
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select"
import { Separator } from "radix-vue"
import { Button } from "@/components/ui/button"
import { ar16X9, ar1X1, ar4X3 } from '@cloudinary/url-gen/qualifiers/aspectRatio';
import { Skeleton } from '@/components/ui/skeleton'

const cloudinaryImage = ref<CloudinaryImage>()
const transformedImage = ref<CloudinaryImage>()
const transformedImageURL = ref('')
const aspectRatio = ref('')
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

const updateAspectRatio = (ar: string) => {
    aspectRatio.value = ar
}

const applyFill = () => {
  if (!cloudinaryImage.value || !aspectRatio.value) {
    return
  }

  if (aspectRatio.value === 'ar1X1') {
    transformedImage.value = cloudinaryImage.value
    .resize(
      pad()
        .width(1500)
        .aspectRatio(ar1X1())
        .background(generativeFill())
    )
    transformedImageURL.value = transformedImage.value.toURL()
  } else if (aspectRatio.value === 'ar4X3') {
    transformedImage.value = cloudinaryImage.value
      .resize(
        pad()
          .width(1500)
          .aspectRatio(ar4X3())
          .background(generativeFill())
      )
      transformedImageURL.value = transformedImage.value.toURL()
    } else if (aspectRatio.value === 'ar16X9') {
    transformedImage.value = cloudinaryImage.value
      .resize(
          pad()
            .width(1500)
            .aspectRatio(ar16X9())
            .background(generativeFill())
        )
      transformedImageURL.value = transformedImage.value.toURL()
    }

  console.log(transformedImageURL.value)
}
</script>
<template>
  <div class="flex flex-col gap-4 focus:ring-0">
    <FormField v-slot="{ componentField }" name="name">
      <FormItem>
        <FormLabel>Image name</FormLabel>
        <FormControl>
          <Input
            type="text"
            placeholder="Input name for Image"
            v-bind="componentField"
          />
        </FormControl>
        <FormMessage />
      </FormItem>
    </FormField>

    <FormField v-slot="{ componentField }" name="ratio">
      <FormItem>
        <FormLabel>Aspect Ratio</FormLabel>

        <Select
          v-bind="componentField"
          class="focus:outline-0 focus:ring-0 focus:no-shadow"
          @update:model-value="updateAspectRatio($event)"
        >
          <FormControl>
            <SelectTrigger>
              <SelectValue placeholder="Select aspect ratio" />
            </SelectTrigger>
          </FormControl>
          <SelectContent>
            <SelectGroup>
              <SelectItem value="ar4X3">
                Standard(4:3)
              </SelectItem>
              <SelectItem value="ar16X9"> Landscape(16:9) </SelectItem>
              <SelectItem value="ar1X1"> Square(1:1) </SelectItem>
            </SelectGroup>
          </SelectContent>
        </Select>
        <FormMessage />
      </FormItem>
    </FormField>

    <Separator />
    <UploaderForm
      @image-uploaded="setImageInformation($event)"
    />

    <Button
      :disabled="!cloudinaryImage || !aspectRatio"
      @click="applyFill()"
    >Apply Fill</Button>

    <Separator />

    <template v-if="transformedImageURL">

      <span class="text-lg">Transposed Image</span>
      <Skeleton v-if="!isTransposing" class="h-[125px] w-full rounded-xl" />
      <AdvancedImage v-show="isTransposing" :cld-img="transformedImage" @load="isTransposing = true"/>
      <Button class="mb-4" variant="secondary" @click=saveImage()>Save Image</Button>
    </template>
  </div>
</template>
