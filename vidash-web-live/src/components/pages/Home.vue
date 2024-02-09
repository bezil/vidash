<script lang="ts" setup>
import { Button } from '@/components/ui/button'
import router from '@/router';

const logout = () => {
  localStorage.removeItem('token')
  router.push("/signin")
}
</script>

<template>
  <p class="text-3xl pb-2">Hello World</p>
  <Button variant="outline" @click="logout()">Logout</Button>
</template>
