<script setup lang="ts">
import { ref } from 'vue'
import { useFileDialog } from '@vueuse/core'
import axios from '@/axios'
import { XSquare } from 'lucide-vue-next'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { Progress } from '@/components/ui/progress'
import * as z from 'zod'
import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
import { Input } from '@/components/ui/input'
import useStore from '@/store/useStore'
import { Separator } from 'radix-vue'

const { user, storeUserDetails } = useStore()

const formSchema = toTypedSchema(
  z.object({
    name:  z.string().min(10).max(20).optional(),
    bio:  z.string().min(10).max(20).optional(),
    gender:  z.string().optional(),
  })
)

const form = useForm({
  validationSchema: formSchema,
})

type userParams = {
  name?: string;
  bio?: string | null,
  avatar?: string | null,
  gender?: string | null,
};

const progress = ref(30)

const isLoading = ref(false)
const imageUploadUrl = ref('')

const imageUrl =  ref('')

const emit = defineEmits(['fetch-details', 'close-dialog'])

const closeDialog = () => {
  emit('close-dialog')
}

const { files, onChange, open, reset } = useFileDialog({
  accept: 'image/*',
  directory: false,
  multiple: false,
})

onChange((selectedFiles) => {
  if (selectedFiles) {
    fetch(imageUploadUrl.value, {
      method: 'PUT',
      body: selectedFiles[0],
      headers: {
        'Content-Type': 'image/*',
      },
    })
      .then(response => {
        console.log('Image upload successful:', response);
      })
      .catch(error => {
        console.error('Error in image upload:', error);
      });
      setTimeout(() => {
        progress.value = 90
        imageUrl.value = imageUploadUrl.value.split('?')[0]
      }, 3000)
  }
})

const updateAccountDetails = (paramObject: userParams) => {
  isLoading.value = true
  if(!user?.id) {
    isLoading.value = false
    return
  }

  console.log(paramObject)

  axios.post(`api/users/${user.id}/update`, {
      user: {
        full_name: paramObject?.name ?? user?.full_name ?? '',
        bio: paramObject.bio ?? user?.bio ?? '',
        avatar: imageUrl.value ?? user?.avatar ?? '',
        gender: paramObject.gender ?? user?.gender ?? '',
      }
    })
    .then((response) => {
      storeUserDetails(response.data.details)
      closeDialog()
    })
    .catch(error => console.error('Error:', error));
    isLoading.value = false
}

const onSubmit = form.handleSubmit((values) => {
  updateAccountDetails(values)
})

const getImageUrl = async () => {
  const response = await axios.get('api/uploads/request_url')
    .catch(() => console.log("Signed url not generated"))

  if (!response) {
    return
  }

  imageUploadUrl.value = response.data.signed_url
}

const clearImage = () => {
  reset()
  imageUrl.value = ''
}

const openImage = () => {
  open()
}

const init = () => {
  getImageUrl()
}

init()
</script>

<template>
<div class="flex flex-row w-full h-full">
    <div class="text-left flex flex-col gap-4 py-6">
    <FormField v-slot="{ componentField }" name="name">
        <FormItem>
            <FormLabel>User name</FormLabel>
            <FormControl>
            <Input
              type="text" placeholder="Input Username" v-bind="componentField"
              :model-value="user?.full_name ?? ''"
            />
            </FormControl>
            <FormMessage />
        </FormItem>
      </FormField>
    <FormField v-slot="{ componentField }" name="bio">
        <FormItem>
            <FormLabel>About Me</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input bio" v-bind="componentField"
            :model-value="user?.bio ?? ''"
            />
            </FormControl>
            <FormMessage />
        </FormItem>
      </FormField>
      <FormField v-slot="{ componentField }" name="gender">
      <FormItem>
        <FormLabel>Gender</FormLabel>

        <Select v-bind="componentField"
          :defaultValue="user?.gender ?? ''"
          class="focus:outline-0 focus:ring-0 focus:no-shadow"
        >
          <FormControl>
            <SelectTrigger>
              <SelectValue placeholder="Select a gender" />
            </SelectTrigger>
          </FormControl>
          <SelectContent>
            <SelectGroup>
              <SelectItem value="Male">
                Male
              </SelectItem>
              <SelectItem value="Female">
                Female
              </SelectItem>
              <SelectItem value="Other">
                Other
              </SelectItem>
            </SelectGroup>
          </SelectContent>
        </Select>
        <FormMessage />
      </FormItem>
    </FormField>

        <div
          v-if="files || user?.avatar"
          class="flex flex-col gap-2 items-center"
        >
          <img v-if="imageUrl" :src="`${imageUrl}`" width="200px" alt="avatar"/>
          <img v-else-if="user?.avatar" :src="`${user.avatar}`" width="200px" alt="avatar"/>

          <Progress v-else v-model="progress" class="w-3/5" />
          <Button variant="destructive" @click="clearImage()">
            <XSquare  class="w-4 h-4 mr-2" /> Remove image
          </Button>
        </div>
        <Button v-else variant="outline" @click="openImage()">
          Select Avatar image to upload
        </Button>
      <Separator />
      <Button @click="onSubmit">Update</Button>
  </div>
</div>
</template>
