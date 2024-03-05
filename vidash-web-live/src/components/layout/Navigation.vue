<script lang="ts" setup>
import { ScrollArea } from "@/components/ui/scroll-area";
import { User, Role } from "@/types/common.ts";
import { Lock, Users, Home, Hammer } from "lucide-vue-next";
import { Separator } from "@/components/ui/separator";
import { ref } from "vue"
import { cn } from '@/lib/utils.ts'

const props = defineProps<{
  user: User;
  current_item: string;
  role?: Role;
}>();

const emit = defineEmits(['navigation-selected'])

const active_item = ref(props.current_item)

const updateSelectedItem = (item_selected: string) => {
  if (!item_selected)  {
    return
  }
  active_item.value = item_selected
  emit('navigation-selected', item_selected)
}
</script>
<template>
  <div class="h-full w-full border-r border-r-grey relative">
    <ScrollArea class="flex-1">
      <div class="flex flex-col h-full">
        <div
          class="flex w-full justify-startpx-2 pt-4 pb-2"
          :class="cn(
            active_item == 'home' && 'border-r bg-secondary/50 border-primary',
          )"
          @click="updateSelectedItem('home')"
        >
          <p
            class="flex items-center uppercase text-ns text-left p-2 w-full cursor-pointer hover:bg-secondary rounded-sm"
          >
            <Home class="w-3 h-3 mr-1 inline text-ring" /> HOME
          </p>
        </div>
        <Separator />

        <div class="flex flex-col w-full items-left text-left px-2 pt-4 pb-2">
          <p class="uppercase text-ns items-center pb-1">
            <Hammer class="w-3 h-3 mr-1 inline text-ring" /> TOOLS
          </p>

          <p
            class="text-sm py-2 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
            :class="cn(
              active_item == 'restore' && 'border-r bg-secondary/50 border-primary',
            )"
            @click="updateSelectedItem('restore')"
          >
            AI Restore
          </p>
          <Separator />

          <p
            class="text-sm py-2 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
            :class="cn(
              active_item == 'fill' && 'border-r bg-secondary/50 border-primary',
            )"
            @click="updateSelectedItem('fill')"
          >
            AI Fill
          </p>
          <Separator />

          <p
            class="text-sm py-2 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
            :class="cn(
              active_item == 'obj_remove' && 'border-r bg-secondary/50 border-primary',
            )"
            @click="updateSelectedItem('obj_remove')"
          >
            Object Remove
          </p>
          <Separator />

          <p
            class="text-sm py-2 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
            :class="cn(
              active_item == 'recolor' && 'border-r bg-secondary/50 border-primary',
            )"
            @click="updateSelectedItem('recolor')"
          >
            Object Recolor
          </p>
          <Separator />

          <p
            class="text-sm py-2 pl-5 pr-1 flex justify-between items-center cursor-pointer hover:bg-secondary rounded-sm"
            :class="cn(
              active_item == 'bg_remove' && 'border-r bg-secondary/50 border-primary',
            )"
            @click="updateSelectedItem('bg_remove')"
          >
            BG Remove
          </p>
        </div>

        <Separator />
        <div class="flex w-full justify-between items-center px-2 pt-4">
          <p class="uppercase text-ns items-center pb-1">
            <Users class="w-3 h-3 mr-1 inline text-ring" /> LIVE
          </p>
          <Lock class="w-3 h-3 mr-1 text-red-500" />
        </div>
      </div>
    </ScrollArea>

    <div class="text-ns bottom-0 absolute mx-auto w-full">
      <div class="text-ns p-2 mx-auto w-full">
        Credits : <span class="bg-secondary px-2 rounded"> 5/5 </span>
      </div>

      <Separator />

      <div
        class="flex gap-2 items-center uppercase text-ns text-left p-2 w-full cursor-pointer hover:bg-secondary rounded-sm"
        :class="cn(
          active_item == 'profile' && 'border-r bg-secondary/50 border-primary',
        )"
        @click="updateSelectedItem('profile')"
      >
        <div
          class="w-6 h-6 rounded-full justify-center bg-secondary uppercase p-1"
        >
          <span class="place-items-center grid text-xs">{{
            user.full_name.split("")[0]
          }}</span>
        </div>
        {{ user.full_name }}
      </div>
    </div>
  </div>
</template>
