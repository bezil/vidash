<script lang="ts" setup>
import NewServer from '@/components/modals/NewServer.vue'
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import ServerOptions from '@/components/layout/ServerOptions.vue'
import useManagePage from '@/composables/useManagePage.ts'
import useStore from '@/store/useStore'

const { account_id } = useStore()

const {
  user_servers, isServerLoading, active_server, isNewServerNeeded,
  updateActiveServer, initializeManagePage, deleteActiveServer,
} = useManagePage()

const deleteHandler = () => {
  if (!active_server.value?.id) {
    return
  }

  deleteActiveServer(active_server.value.id)
}

initializeManagePage()
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
    <div class="flex flex-1 justify-center items-center">
    </div>
  </template>

  <NewServer
    :open="isNewServerNeeded && !isServerLoading"
    :account-id="account_id"
    @close-dialog="isNewServerNeeded = false"
    @fetch-details="initializeManagePage()"
  />
</template>
