<script lang="ts" setup>
import Navigation from '@/components/layout/Navigation.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'
import Profile from '@/components/pages/Profile.vue'
import Credits from '@/components/pages/Credits.vue'
import ToolsFormPage from '@/components/pages/ToolsFormPage.vue'

import { ScrollArea } from '@/components/ui/scroll-area'
import Skeleton from '../ui/skeleton/Skeleton.vue'

const { member, current_user, current_navigation,
  currentNavigationItem,
  updateActiveNavigationItem, initializeDashboardPage
} = useDashboardPage()

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-full h-full">
    <template class="flex w-[120px] md:w-[210px] z-10">
      <Navigation
        v-if="current_user
          && (member?.role === 'ADMIN'
          || member?.role === 'MODERATOR'
          || member?.role === 'GUEST')"
        :role="member.role"
        :user="current_user"
        :current_item="current_navigation"
        @navigation-selected="updateActiveNavigationItem($event)"
      />
      <Skeleton v-else class="h-full w-full border-r border-r-grey"/>
    </template>
    <div class="flex flex-1 flex-col pt-8">
      <ScrollArea class="flex-1 h-full px-8 md:px-12">
        <div
        v-if="!!currentNavigationItem"
        class="text-left"
      >
        <h1 class="text-3xl">{{ currentNavigationItem.title }}</h1>
        <h4 class="text-sm">{{ currentNavigationItem.subtitle }}</h4>
      </div>
      <Profile
        v-if="currentNavigationItem?.id === 'profile'"
      />
      <Credits
        v-else-if="currentNavigationItem?.id === 'credits'"
      />
      <ToolsFormPage
        v-else-if="!!currentNavigationItem?.id"
        :type="currentNavigationItem?.id"
      />
      </ScrollArea>
    </div>
  </template>
</template>
