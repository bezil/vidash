<script lang="ts" setup>
import { Server } from '@/types/common.ts'
import { ScrollArea } from '@/components/ui/scroll-area'
import { MonitorDot, ChevronsUpDown, Trash, Lock, ListPlus,
  Users, Hammer, TableProperties, Bot, Radio, UserRoundPlus,
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
  visitors?: number
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
            <DropdownMenuLabel class="font-light text-xs">Dash Options</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem>
                <UserRoundPlus class="mr-2 h-3 w-3" />
                <span class="text-sm">Invite Member</span>
            </DropdownMenuItem>
            <DropdownMenuItem>
                <ListPlus class="mr-2 h-3 w-3" />
                <span class="text-sm">Add Channel</span>
            </DropdownMenuItem>
            <DropdownMenuItem>
                <Trash class="mr-2 h-3 w-3" />
                <span class="text-sm" @click="deleteServer">Delete Dash</span>
            </DropdownMenuItem>
            </DropdownMenuContent>
        </DropdownMenu>
      </div>

      <ScrollArea class="flex-1">
        <div class="flex flex-col space-between">
          <div class="flex w-full justify-between items-center px-2 pt-4">
            <p class="uppercase text-ns items-center pb-1"><Users class="w-3 h-3 mr-1 inline text-ring" /> MEMBERS</p>
            <Lock class="w-3 h-3 mr-1  text-red-500"/>
          </div>
          <div class="flex w-full justify-between items-center px-2 pt-4">
            <p class="uppercase text-ns items-center pb-1"><TableProperties class="w-3 h-3 mr-1 inline text-ring" /> CHANNELS</p>
            <Lock class="w-3 h-3 mr-1  text-red-500"/>
          </div>
          <div class="flex flex-col w-full items-left text-left px-2 pt-4">
            <p class="uppercase text-ns items-center pb-1"><Hammer class="w-3 h-3 mr-1 inline text-ring" /> TOOLS</p>
            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">Live
              <Radio class="w-4 h4 inline text-ring" />
            </p>
            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">AI
              <Bot class="w-4 h-4 inline text-ring" />
            </p>
          </div>
        </div>
      </ScrollArea>

      <div v-if="visitors" class="text-ns bottom-0 absolute p-2 mx-auto w-full">
        Online : <span class="bg-secondary px-2 rounded"> {{ visitors + 1 }} Visitors </span>
      </div>
  </div>
</template>
