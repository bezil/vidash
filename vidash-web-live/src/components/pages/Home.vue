<script lang="ts" setup>
import axios from '@/axios';

const fetchUserAccount = async () => {
  await axios.get(`api/accounts/by_id/${localStorage.getItem('auth_id')}`)
}

const init = () => {
  fetchUserAccount()
}

init()
</script>

<template>

</template>
