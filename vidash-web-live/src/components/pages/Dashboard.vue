<script lang="ts" setup>
import SetupServer from '@/components/modals/SetupServer.vue'
import NewServer from '@/components/modals/NewServer.vue'
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'
import useStore from '@/store/useStore'

const { account_id } = useStore()

const {
  user_servers, isServerLoading, isServerAlreadySetup,
  isNewServerNeeded,
  initializeDashboardPage,
} = useDashboardPage()

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-[60px] h-full z-10">
    <ServerSidebar
      v-if="user_servers?.length"
      :servers="user_servers"
      @add-requested="isNewServerNeeded = true"
    />
  </template>


  <SetupServer
    v-if="!isServerAlreadySetup && !isServerLoading"
    :dialog-visible="!isServerAlreadySetup"
    :account-id="account_id"
    @fetch-details="initializeDashboardPage()"
  />

  <NewServer
    :open="isNewServerNeeded && !isServerLoading"
    :account-id="account_id"
    @close-dialog="isNewServerNeeded = false"
    @fetch-details="initializeDashboardPage()"
  />
</template>
