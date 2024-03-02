<script lang="ts" setup>
import NewServer from '@/components/modals/NewServer.vue'
import Authorize from '@/components/modals/Authorize.vue'
import ServerSidebar from '@/components/layout/ServerSidebar.vue'
import ServerOptions from '@/components/layout/ServerOptions.vue'
import useManagePage from '@/composables/useManagePage.ts'
import useStore from '@/store/useStore'

const { account_id } = useStore()

const {
  user_servers, isServerLoading, active_server, isNewServerNeeded, isValidToken,
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
        v-if="isValidToken"
        :servers="user_servers"
        @add-requested="isNewServerNeeded = true"
        @server-updated="updateActiveServer($event)"
      />
    </template>
    <template class="flex w-[150px] md:w-[210px] z-5">
      <ServerOptions
        v-if="active_server && isValidToken"
        :server="active_server"
        @delete-requested="deleteHandler"
      />
    </template>
    <div v-if="isValidToken" class="flex flex-1 justify-center items-center">
    </div>
  </template>

  <NewServer
    v-if="isNewServerNeeded && isValidToken"
    :open="isNewServerNeeded && !isServerLoading"
    :account-id="account_id"
    @close-dialog="isNewServerNeeded = false"
    @fetch-details="initializeManagePage()"
  />

  <Authorize
    v-if="!!account_id && !isValidToken && !!user_servers"
    :open="!isValidToken"
    :account-id="account_id"
    :server-name="user_servers[0]?.name"
    @validated="isValidToken=true"
    @denied="isValidToken=false"
  />
</template>
