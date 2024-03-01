<script lang="ts" setup>
import { ref } from 'vue'
import { CircleFadingPlus } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import useStore from '@/store/useStore'
import { Server } from '@/types/common.ts'
import { cn } from '@/lib/utils.ts'
import { Separator } from '@/components/ui/separator'

const { isAuthenticated, user } = useStore()

import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from '@/components/ui/tooltip'
import { ScrollArea } from '@/components/ui/scroll-area'

const emit = defineEmits(['add-requested', 'server-updated'])

const activeServer = ref('')

defineProps<{
  servers?: Server[]
}>()

const addServer = () => {
  emit('add-requested')
}

const openServerClicked = (selected?: string): void => {
  if(!selected) {
    return
  }
  activeServer.value = selected
  emit('server-updated', activeServer.value)
}
</script>
<template>
  <div class="py-3 h-full w-full border-r border-r-grey flex flex-col justify-between">
    <TooltipProvider v-if="isAuthenticated">
        <Tooltip>
          <TooltipTrigger>
            <Button variant="secondary" @click="addServer" class="px-3 rounded-full hover:rounded-2xl mb-3">
              <CircleFadingPlus class="w-4 h-4"/>
            </Button>
          </TooltipTrigger>
          <TooltipContent class="absolute top-2 left-5 w-[150px]">
            <p>Add New Server</p>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>

    <Separator orientation="horizontal" class="mx-auto w-[30px]" />

    <ScrollArea class="flex-1">
      <div
        v-for="server in servers" :key="server.id"
        :class="
          cn(
            'w-full flex items-center justify-center py-2',
            activeServer == server.id && 'border-r bg-secondary/50 border-primary',
          )"
        @click="openServerClicked(server.id)"
      >
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger>
              <img
                v-if="server.image_url"
                class="w-8 h-8 rounded-full mx-auto" :src="server.image_url" alt="server image"
              />
              <div class="w-8 h-8 rounded-full mx-auto pt-1 bg-secondary uppercase" v-else>
                {{ server.name.split('')[0] }}
              </div>
          </TooltipTrigger>
          <TooltipContent class="absolute top-2 left-5 w-[180px]">
            <p>{{ server.name }}</p>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>
      </div>
    </ScrollArea>

    <Separator orientation="horizontal" class="mx-auto w-[30px]" />

    <TooltipProvider v-if="isAuthenticated && user?.full_name">
        <Tooltip>
          <TooltipTrigger>
            <div class="w-8 h-8 rounded-full mx-auto pt-1 mt-3 bg-secondary uppercase">
                {{ user.full_name.split('')[0] }}
              </div>
          </TooltipTrigger>
          <TooltipContent class="absolute top-1 left-5 w-[180px]">
            <div class="text-ns text-ring uppercase">Logged In User</div>
            <div class="text-sm">{{ user.full_name }}</div>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>
  </div>
</template>
