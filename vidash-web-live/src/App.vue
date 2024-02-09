<script setup lang="ts">
import { LogOut } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import { computed } from 'vue'
import DarkMode from '@/components/theme/DarkMode.vue'
import router from '@/router';

const isAuthenticated = computed(
  () => localStorage.getItem('token') && localStorage.getItem('auth_id')
)

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('auth_id')
  router.push("/signin").then(() => router.go(0))
}
</script>

<template>
  <div class="h-[40px] w-full flex flex-row justify-between items-center py-2 border-b border-b-grey">
    <p class="px-4">Vidash <b><i>LIVE</i></b></p>
    <div>
      <DarkMode />
      <Button v-if="isAuthenticated" variant="ghost" @click="logout()">
        <LogOut class="w-4 h-4 mr-2"/> Logout
      </Button>
    </div>
  </div>
  <router-view></router-view>
</template>

<style>
html.dark {
  color-scheme: dark;
}
</style>
