<script lang="ts" setup>
import axios from '@/axios';
import { computed, ref } from 'vue';
import SetupServer from '@/components/modals/SetupServer.vue'

type User = {
  full_name: string,
  id: string,
}
const user = ref<User>();
const isServerAlreadySetup = ref(false);

const accountId = computed(() => localStorage.getItem('auth_id'))

const fetchUserAccount = async () => {
  const response = await axios.get(`api/users/${accountId.value}`)

  if(response) {
    user.value = response.data.details
  }
}

const fetchServerDetails = async () => {
  const response = await axios.get(`api/servers/by_user_id/${user.value?.id}`)

  if(response) {
    console.log(response.data.details)
    isServerAlreadySetup.value = true;
  } else {
    console.log("No server found")
  }
}

const init = async () => {
  await fetchUserAccount()
  fetchServerDetails()
}

init()
</script>

<template>
  <p class="py-4 text-center">Hello {{ user?.full_name }} !!</p>
  <SetupServer
    v-if="!isServerAlreadySetup"
    :dialog-visible="!isServerAlreadySetup"
    :account-id="accountId"
  />
</template>
