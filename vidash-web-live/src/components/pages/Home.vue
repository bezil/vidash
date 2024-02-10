<script lang="ts" setup>
import axios from '@/axios';
import { ref } from 'vue';

const username = ref();

const fetchUserAccount = async () => {
  const response = await axios.get(`api/users/${localStorage.getItem('auth_id')}`)

  if(response) {
    username.value = response.data.details.full_name
  }
}

const fetchServerDetails = async () => {
  const response = await axios.get(`api/servers/by_user_id/${localStorage.getItem('auth_id')}`)

  if(response) {
    console.log(response.data.details)
  } else {
    console.log("No server found")
  }
}

const init = () => {
  fetchUserAccount()
  fetchServerDetails()
}

init()
</script>

<template>
  <p class="py-4 text-center">Hello {{ username }} !!</p>
</template>
