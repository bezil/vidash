<script setup lang="ts">
import { computed, ref } from 'vue'
import { useFileDialog } from '@vueuse/core'
import axios from '@/axios'
import { XSquare } from 'lucide-vue-next'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
import { Progress } from '@/components/ui/progress'
import * as z from 'zod'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'

const props = withDefaults(defineProps<{
  dialogVisible?: boolean
  accountId: string | null
}>(), {
  dialogVisible: true,
  accountId: '',
})

const formSchema = toTypedSchema(
  z.object({
    name:  z.string().min(1, {
      message: "Server name is required"
    }).max(20),
  })
)

const form = useForm({
  validationSchema: formSchema,
})

type serverParams = {
  name: string,
};

const progress = ref(13)

const isLoading = ref(false)
const isDialogVisible = ref(props.dialogVisible)
const imageUploadUrl = ref('')

const imageUrl =  ref('')
const id = computed(() => props.accountId)

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
        progress.value = 70
        imageUrl.value = imageUploadUrl.value.split('?')[0]
      }, 2000)
  }
})

const createServer = (paramObject: serverParams) => {
  isLoading.value = true
  axios.post('api/servers/create', {
      acc_id: id.value,
      server: {
        name: paramObject.name,
        image_url: imageUrl.value,
        invite_code: null,
      }
    })
    .then(() => {
      form.resetForm()
      isDialogVisible.value = false
    })
    .catch(error => console.error('Error:', error));
    isLoading.value = false
}

const onSubmit = form.handleSubmit((values) => {
  createServer(values)
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
  <Dialog
    :open="isDialogVisible"
  >
    <DialogContent>
      <DialogHeader>
        <DialogTitle>Setup your Server</DialogTitle>
        <DialogDescription>
          Setup your Vidash Live Server with name and image.
        </DialogDescription>
      </DialogHeader>
      <FormField v-slot="{ componentField }" name="name">
        <FormItem>
            <FormLabel>Server Name</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input server name" v-bind="componentField" />
            </FormControl>
            <FormMessage />
        </FormItem>
        </FormField>
        <div
          v-if="files"
          class="flex flex-col gap-2 items-center"
        >
          <img v-if="imageUrl" :src="`${imageUrl}`" width="200px" :alt=" files[0].name"/>
          <Progress v-else v-model="progress" class="w-3/5" />
          <Button variant="destructive" @click="clearImage()">
            <XSquare  class="w-4 h-4 mr-2" /> Remove image
          </Button>
        </div>
        <Button v-else variant="outline" @click="openImage()">
          Select Avatar image to upload
        </Button>
      <DialogFooter>
        <Button @click="onSubmit">Create Server</Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>
