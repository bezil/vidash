<script lang="ts" setup>
import { Server } from '@/types/common.ts'
import { ScrollArea } from '@/components/ui/scroll-area'
import { MonitorDot, ChevronsUpDown, Trash } from 'lucide-vue-next'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu'

defineProps<{
  server: Server
}>()

const emit = defineEmits(['delete-requested'])

const deleteServer = () => {
  emit('delete-requested')
}

</script>
<template>
  <div class="h-full w-full border-r border-r-grey">
      <div class="w-full px-2 md:px-3 py-3 border-b border-b-grey text-left flex flex-row justify-between items-center">
        <div class="text-ring text-ns pt-1">
            <div class="flex uppercase"><MonitorDot class="w-3 h-3 mr-2 text-lime-500"/>ACTIVE DASH </div>
            <p class="text-sm md:text-lg font-medium">{{ server.name }}</p>
        </div>
        <DropdownMenu>
            <DropdownMenuTrigger>
                <ChevronsUpDown  class="w-4 h-4" />
            </DropdownMenuTrigger>
            <DropdownMenuContent>
            <DropdownMenuLabel class="font-light text-sm">Dash Options</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem>
                <Trash class="mr-2 h-4 w-4" />
                <span @click="deleteServer">Delete Dash</span>
            </DropdownMenuItem>
            </DropdownMenuContent>
        </DropdownMenu>
      </div>
      <ScrollArea class="flex-1"></ScrollArea>
  </div>
</template>
