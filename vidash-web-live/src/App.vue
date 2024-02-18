<script setup lang="ts">
import { LogOut } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import { computed } from 'vue'
import Toaster from '@/components/ui/toast/Toaster.vue'
import DarkMode from '@/components/theme/DarkMode.vue'
import router from '@/router';
import { useDark } from '@vueuse/core'

const isDark = useDark()

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
    <img v-if="isDark" src="/logo.png" class="h-4 px-4" />
    <img v-else src="/logo-dark.png" class="h-4 px-4" />

    <div>
      <DarkMode />
      <Button v-if="isAuthenticated" variant="ghost" @click="logout()">
        <LogOut class="w-4 h-4 mr-2"/> Logout
      </Button>
    </div>
  </div>
  <router-view></router-view>
  <Toaster />
</template>

<style>
html.dark {
  color-scheme: dark;
}
</style>
