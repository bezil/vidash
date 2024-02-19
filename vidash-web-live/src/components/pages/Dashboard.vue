<script lang="ts" setup>
import { computed } from 'vue';
import SetupServer from '@/components/modals/SetupServer.vue'
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import useHomePage from '@/composables/useDashboardPage.ts'
import useStore from '@/store/useStore'

const { account_id } = useStore()

const {
  user_server, isServerLoading, isServerAlreadySetup, initializeDashboardPage,
} = useHomePage()

const imageUrl = computed(() => user_server.value?.image_url ?? '')

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-[60px] z-10">
    <ServerSidebar
      :image-url="imageUrl"
      :server-name="user_server?.name"
    />
  </template>


  <SetupServer
    v-if="!isServerAlreadySetup && !isServerLoading"
    :dialog-visible="!isServerAlreadySetup"
    :account-id="account_id"
    @fetch-details="initializeDashboardPage()"
  />
</template>
