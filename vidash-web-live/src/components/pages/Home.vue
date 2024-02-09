<script lang="ts" setup>
import axios from '@/axios';
import { ref } from 'vue';

const username = ref();

const fetchUserAccount = async () => {
  const response = await axios.get(`api/users/${localStorage.getItem('auth_id')}`)

  if(response) {
    username.value = response.data.data.full_name
  }
}

const init = () => {
  fetchUserAccount()
}

init()
</script>

<template>
  <p class="py-4 text-center">Hello {{ username }} !!</p>
</template>
