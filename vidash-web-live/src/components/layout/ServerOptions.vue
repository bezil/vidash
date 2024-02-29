<script lang="ts" setup>
import { Server } from '@/types/common.ts'
import { ScrollArea } from '@/components/ui/scroll-area'
import { MonitorDot, ChevronsUpDown, Trash, Lock,
  Users, Hammer, TableProperties, Bot, Radio,
} from 'lucide-vue-next'
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
  visitors: number
}>()

const emit = defineEmits(['delete-requested'])

const deleteServer = () => {
  emit('delete-requested')
}

</script>
<template>
  <div class="h-full w-full border-r border-r-grey relative">
      <div class="w-full px-2 md:px-3 py-3 border-b border-b-grey text-left flex flex-row justify-between items-center">
        <div class="text-ring text-ns">
            <div class="flex uppercase"><MonitorDot class="w-3 h-3 mr-2 text-lime-500"/>ACTIVE DASH
            </div>
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

      <ScrollArea class="flex-1">
        <div class="flex flex-col space-between">
          <div class="flex w-full justify-between items-center px-2 pt-4">
            <p class="uppercase text-ns items-center"><Users class="w-3 h-3 mr-1 inline text-ring" /> MEMBERS</p>
            <Lock class="w-3 h-3 mr-1  text-red-500"/>
          </div>
          <div class="flex w-full justify-between items-center px-2 pt-4">
            <p class="uppercase text-ns items-center"><TableProperties class="w-3 h-3 mr-1 inline text-ring" /> CHANNELS</p>
            <Lock class="w-3 h-3 mr-1  text-red-500"/>
          </div>
          <div class="flex flex-col w-full items-left text-left px-2 pt-4">
            <p class="uppercase text-ns items-center"><Hammer class="w-3 h-3 mr-1 inline text-ring" /> TOOLS</p>
            <p class="text-sm mt-1 px-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">Live
              <Radio class="w-4 h4 inline text-ring" />
            </p>
            <p class="text-sm mt-1 px-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">AI
              <Bot class="w-4 h-4 inline text-ring" />
            </p>
          </div>
        </div>
      </ScrollArea>

      <div class="text-ns bottom-0 absolute p-2 mx-auto w-full">
        Online : <span class="bg-secondary px-2 rounded"> {{ visitors + 1 }} Visitors </span>
      </div>
  </div>
</template>
