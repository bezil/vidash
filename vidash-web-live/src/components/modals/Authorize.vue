<script setup lang="ts">
import { X } from 'lucide-vue-next'

import { computed } from 'vue'
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
  serverName?: string
}>(), {
  dialogVisible: true,
  accountId: '',
})

const formSchema = toTypedSchema(
  z.object({
    name:  z.string().min(1, {
      message: "Token is required"
    }).max(20),
  })
)

const form = useForm({
  validationSchema: formSchema,
})

const id = computed(() => props.accountId)

const emit = defineEmits(['validated', 'denied', 'close-dialog'])

const closeDialog = () => {
  emit('close-dialog')
}

const authorize = (params: { name: string } ) => {
  if (!!props.serverName
    && (params.name === props.serverName.split(' ').join('-').toLowerCase())
    && !!id) {
      form.resetForm()
      emit('validated')
      closeDialog()
    } else {
        emit('denied')
    }
}

const onSubmit = form.handleSubmit((values) => {
  authorize(values)
})
</script>

<template>
  <Dialog>
    <DialogContent>
      <DialogHeader>
        <DialogTitle>Authorize Access</DialogTitle>
        <DialogDescription>
          Give Token to get access.
        </DialogDescription>
      </DialogHeader>
      <FormField v-slot="{ componentField }" name="name">
        <FormItem>
            <FormLabel>Dash Name</FormLabel>
            <FormControl>
            <Input type="text" placeholder="Input dash name" v-bind="componentField" />
            </FormControl>
            <FormMessage />
        </FormItem>
        </FormField>
      <DialogFooter>
        <Button @click="onSubmit">Submit</Button>
      </DialogFooter>

      <template #close>
        <X class="w-4 h-4" @click="closeDialog"/>
        <span class="sr-only">Close</span>
      </template>
    </DialogContent>
  </Dialog>
</template>
