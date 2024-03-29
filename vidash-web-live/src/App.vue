<script setup lang="ts">
import { LogOut, LogIn, LayoutDashboard, ChevronLeft } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import Toaster from '@/components/ui/toast/Toaster.vue'
import DarkMode from '@/components/theme/DarkMode.vue'
import router from '@/router';
import useRouteUtils from '@/lib/route.ts';
import { useDark } from '@vueuse/core'
import useStore from '@/store/useStore'
import { ref, computed } from 'vue'
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger
} from '@/components/ui/tooltip'

const { isAuthenticated, resetStore } = useStore()

const isDark = useDark()

const { route } = useRouteUtils()

const isBackNeeded = ref(false)

const isDashButtonNeeded = computed(
  () =>  !!route?.name && ['play', 'home'].includes(route.name.toString())
)

const goToHome = () => {
  router.push("/")
}

const goBack = () => {
  router.go(-1)
}

const goToDashboard = () => {
  router.push("/dash")
}

const login = () => {
  router.push("/signin")
}

const logout = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('auth_id')
  resetStore()
  router.push("/signin").then(() => router.go(0))
}
</script>

<template>
  <div class="h-[40px] bg-white dark:bg-slate-900 w-full flex flex-row justify-between items-center py-2 border-b border-b-grey">
    <img v-if="isDark" src="/logo.png" class="h-4 px-4 cursor-pointer" @click="goToHome"/>
    <img v-else src="/logo-dark.png" class="h-4 px-4 cursor-pointer" @click="goToHome"/>

    <div>
      <Button v-if="isBackNeeded" variant="ghost" @click="goBack()">
        <ChevronLeft class="w-4 h-4"/>
      </Button>
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger>
            <Button v-if="isAuthenticated && isDashButtonNeeded" variant="ghost" alt="Go to Dash" @click="goToDashboard()">
              <LayoutDashboard class="w-4 h-4"/>
            </Button>
          </TooltipTrigger>
          <TooltipContent>
            <p>Go to Dashboard</p>
          </TooltipContent>
        </Tooltip>
      </TooltipProvider>
      <DarkMode />
      <Button v-if="isAuthenticated" variant="ghost" @click="logout()">
        <LogOut class="w-4 h-4 mr-2"/> Logout
      </Button>
      <Button v-else variant="ghost" @click="login()">
        <LogIn class="w-4 h-4 mr-2"/> Login
      </Button>
    </div>
  </div>

  <div class="app-canvas">
    <router-view></router-view>
  </div>
  <Toaster />

  <div class="fixed bottom-0 border-t border-t-grey h-[25px] bg-white dark:bg-stone-900/10 w-full flex flex-row justify-end items-center py-1 px-2 z-1">
    <div class="flex items-center">
    <img v-if="isDark" src="/logo.png" class="h-2 px-2" />
    <img v-else src="/logo-dark.png" class="h-2 px-2" />
    <span class="text-ns">© 2024
      <a href="https://devbez.digital/" target="_blank" class="text-cyan-500 pr-2">DEVBEZ Digital</a>
    </span>
    </div>
  </div>
</template>

<style>
html.dark {
  color-scheme: dark;
}
.app-canvas {
  height: calc(100vh - 65px);
}
</style>
