<script lang="ts" setup>
import axios from '@/axios';
import { computed, ref } from 'vue';
import SetupServer from '@/components/modals/SetupServer.vue'

type User = {
  full_name: string,
  id: string,
}

type Server = {
  name: string,
  image_url?: string,
}

const user = ref<User>();
  const isLoading = ref(true);

const isServerAlreadySetup = ref(false);
const serverDetails = ref<Server>()

const accountId = computed(() => localStorage.getItem('auth_id'))

const imageUrl = computed(() => serverDetails.value?.image_url)

const fetchUserAccount = async () => {
  const response = await axios.get(`api/users/${accountId.value}`)

  if(response) {
    user.value = response.data.details
  }
}

const fetchServerDetails = async () => {
  isLoading.value = true

  const response = await axios.get(`api/servers/by_user_id/${user.value?.id}`)
    .catch(() => console.log("No server found"))

  if(response) {
    console.log(response.data.details)
    isServerAlreadySetup.value = true;
    serverDetails.value = response.data.details
  }

  isLoading.value = false
}

const init = async () => {
  await fetchUserAccount()
  fetchServerDetails()
}

init()
</script>

<template>
  <p class="py-4 text-center">Hello {{ user?.full_name }} !!</p>
  <p class="py-2 text-center"> Connected to {{ serverDetails?.name }}</p>

  <img
    v-if="imageUrl"
    class="w-24 h-24 rounded-full mx-auto" :src="imageUrl" alt="server image" width="200"
  />

  <SetupServer
    v-if="!isServerAlreadySetup && !isLoading"
    :dialog-visible="!isServerAlreadySetup"
    :account-id="accountId"
    @fetch-details="init()"
  />
</template>
