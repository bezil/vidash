<script lang="ts" setup>
import { CircleFadingPlus } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import useStore from '@/store/useStore'
import { Server } from '@/types/common.ts'

const { isAuthenticated } = useStore()

import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from '@/components/ui/tooltip'
import { ScrollArea } from '@/components/ui/scroll-area'

const emit = defineEmits(['add-requested'])

defineProps<{
  servers: Server[]
}>()

const addServer = () => {
  emit('add-requested')
}
</script>
<template>
  <div class="py-3 h-full w-full border-r border-r-grey flex flex-col gap-4">
    <TooltipProvider v-if="isAuthenticated">
        <Tooltip>
          <TooltipTrigger>
            <Button variant="secondary" @click="addServer" class="px-3 rounded-full hover:rounded-2xl">
              <CircleFadingPlus class="w-4 h-4"/>
            </Button>
          </TooltipTrigger>
          <TooltipContent class="absolute top-2 left-5 w-[150px]">
            <p>Add New Server</p>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider v-for="server in servers" :key="server.name">
        <Tooltip>
          <TooltipTrigger>
            <img
              v-if="server.image_url"
              class="w-8 h-8 rounded-full mx-auto" :src="server.image_url" alt="server image"
            />
          </TooltipTrigger>
          <TooltipContent class="absolute top-1 left-5">
            <p>{{ server.name }}</p>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>
    <ScrollArea>

    </ScrollArea>
  </div>
</template>
