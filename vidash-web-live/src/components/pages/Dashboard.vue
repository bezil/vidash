<script lang="ts" setup>
import Navigation from '@/components/layout/Navigation.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'

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
        v-if="member?.role === 'GUEST' && current_user"
        :role="member.role"
        :user="current_user"
        :current_item="current_navigation"
        @navigation-selected="updateActiveNavigationItem($event)"
      />
    </template>
    <div class="flex flex-1 pt-8 px-8 md:px-12">
      <div
        v-if="!!currentNavigationItem"
        class="text-left"
      >
        <h1 class="text-3xl">{{ currentNavigationItem.title }}</h1>
        <h4 class="text-sm">{{ currentNavigationItem.subtitle }}</h4>
      </div>
    </div>
  </template>
</template>
