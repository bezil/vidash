<script setup lang="ts">
import { computed, ref } from 'vue'
import axios from '@/axios'
import { useForm } from 'vee-validate'
import { toTypedSchema } from '@vee-validate/zod'
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
    image_url: z.string(),
  })
)

const form = useForm({
  validationSchema: formSchema,
})

type serverParams = {
  name: string,
  image_url: string
};

const isLoading = ref(false)
const isDialogVisible = ref(props.dialogVisible)
const id = computed(() => props.accountId)

const createServer = (paramObject: serverParams) => {
  isLoading.value = true
  axios.post('api/servers/create', {
      acc_id: id.value,
      server: {
        name: paramObject.name,
        image_url: paramObject.image_url,
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
        <FormField v-slot="{ componentField }" name="image_url">
        <FormItem>
            <FormLabel>Image Url</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input server image url" v-bind="componentField" />
            </FormControl>
            <FormMessage />
        </FormItem>
        </FormField>
      <DialogFooter>
        <Button @click="onSubmit">Create Server</Button>
      </DialogFooter>
    </DialogContent>
  </Dialog>
</template>
