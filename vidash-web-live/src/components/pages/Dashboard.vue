<script lang="ts" setup>
import SetupServer from '@/components/modals/SetupServer.vue'
import NewServer from '@/components/modals/NewServer.vue'
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import ServerOptions from '@/components/layout/ServerOptions.vue'
import useDashboardPage from '@/composables/useDashboardPage.ts'
import useStore from '@/store/useStore'

const { account_id } = useStore()

const {
  user_servers, isServerLoading, isServerAlreadySetup, active_server,
  isNewServerNeeded, updateActiveServer, initializeDashboardPage,
  deleteActiveServer,
} = useDashboardPage()

const deleteHandler = () => {
  if (!active_server.value?.id) {
    return
  }

  deleteActiveServer(active_server.value.id)
}

initializeDashboardPage()
</script>

<template>
  <template class="flex flex-row w-full h-full">
    <template class="flex w-[60px] z-10">
      <ServerSidebar
        v-if="user_servers?.length"
        :servers="user_servers"
        @add-requested="isNewServerNeeded = true"
        @server-updated="updateActiveServer($event)"
      />
    </template>
    <template class="flex w-[150px] md:w-[210px] z-5">
      <ServerOptions
        v-if="active_server"
        :server="active_server"
        @delete-requested="deleteHandler"
      />
    </template>
    <div class="flex flex-1 justify-center items-center">{{ active_server?.name }}</div>
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
