<script lang="ts" setup>
import Navigation from '@/components/layout/Navigation.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'

const { member, current_user, initializeDashboardPage
} = useDashboardPage()

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-full h-full">
    <template class="flex w-[160px] md:w-[210px] z-10">
      <Navigation
        v-if="member?.role === 'GUEST' && current_user"
        :role="member.role"
        :user="current_user"
      />
    </template>
    <div class="flex flex-1 justify-center items-center">
    </div>
  </template>
</template>
