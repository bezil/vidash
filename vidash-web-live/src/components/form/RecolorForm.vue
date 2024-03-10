<script lang="ts" setup>
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

    <Button variant="secondary">
          Save Image
        </Button>
      <Button>Recolor Object</Button>
    </div>
</template>
