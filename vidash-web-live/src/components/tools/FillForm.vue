<script lang="ts" setup>
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'
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

      <FormField v-slot="{ componentField }" name="ratio">
      <FormItem>
        <FormLabel>Aspect Ratio</FormLabel>

        <Select v-bind="componentField"
          class="focus:outline-0 focus:ring-0 focus:no-shadow"
        >
          <FormControl>
            <SelectTrigger>
              <SelectValue placeholder="Select aspect ratio" />
            </SelectTrigger>
          </FormControl>
          <SelectContent>
            <SelectGroup>
              <SelectItem value="landscape">
                Standard Portrait(3:4)
              </SelectItem>
              <SelectItem value="portrait">
                Phone Portrait(9:16)
              </SelectItem>
              <SelectItem value="square">
                Square(1:1)
              </SelectItem>
            </SelectGroup>
          </SelectContent>
        </Select>
        <FormMessage />
      </FormItem>
    </FormField>

    <Separator />

    <Button variant="outline">
          Save Image
        </Button>
      <Button>Apply Fill</Button>
    </div>
</template>
