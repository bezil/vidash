<script lang="ts" setup>
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'

const { user_servers, updateActiveServer, initializeDashboardPage } = useDashboardPage()

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-full h-full">
    <template class="flex w-[60px] z-10">
      <ServerSidebar
        v-if="user_servers?.length"
        :servers="user_servers"
        @server-updated="updateActiveServer($event)"
      />
    </template>
    <div class="flex flex-1 justify-center items-center">
    </div>
  </template>
</template>
