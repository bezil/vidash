<script lang="ts" setup>
import { ScrollArea } from '@/components/ui/scroll-area'
import { User, Role } from '@/types/common.ts'
import { Lock, Users, Home, Hammer,
} from 'lucide-vue-next'
import router from '@/router'
import { Separator } from '@/components/ui/separator'

defineProps<{
  user: User
  role?: Role
}>()

</script>
<template>
  <div class="h-full w-full border-r border-r-grey relative">
      <ScrollArea class="flex-1">
        <div class="flex flex-col h-full">
          <div class="flex w-full justify-startpx-2 pt-4 pb-2">
            <p class="flex items-center uppercase text-ns text-left p-2 w-full cursor-pointer hover:bg-secondary rounded-sm">
              <Home class="w-3 h-3 mr-1 inline text-ring" /> HOME</p>
          </div>
          <Separator />

          <div class="flex flex-col w-full items-left text-left px-2 pt-4 pb-2">
            <p class="uppercase text-ns items-center pb-1"><Hammer class="w-3 h-3 mr-1 inline text-ring"/> TOOLS</p>
            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
              @click="router.push('/transpose')"
            >AI Restore</p>
            <Separator />

            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">
              AI Fill</p>
              <Separator />

            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
              @click="router.push('/transpose')"
            >Object Remove</p>
            <Separator />

            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">
              Object Recolor</p>
              <Separator />

            <p class="text-sm py-1 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm">
              BG Remove</p>
          </div>

          <Separator />
          <div class="flex w-full justify-between items-center px-2 pt-4">
            <p class="uppercase text-ns items-center pb-1"><Users class="w-3 h-3 mr-1 inline text-ring" /> LIVE</p>
            <Lock class="w-3 h-3 mr-1  text-red-500"/>
          </div>
        </div>
      </ScrollArea>

      <div class="text-ns bottom-0 absolute mx-auto w-full">
        <div class="text-ns p-2 mx-auto w-full">
          Credits : <span class="bg-secondary px-2 rounded"> 5/5 </span>
        </div>

        <Separator />

        <p class="flex gap-2 items-center uppercase text-ns text-left p-2 w-full rounded-sm">
          <div class="w-6 h-6 rounded-full justify-center bg-secondary uppercase p-1">
            <span class="place-items-center grid text-xs">{{ user.full_name.split('')[0] }}</span>
          </div>
          {{ user.full_name }}
        </p>
      </div>
  </div>
</template>
