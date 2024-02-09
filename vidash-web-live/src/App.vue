<script setup lang="ts">
import DarkMode from '@/components/theme/DarkMode.vue'
</script>

<template>
  <div class="h-[60px] w-full flex flex-row justify-end p-2 border-b border-b-grey">
    <DarkMode />
  </div>
  <router-view></router-view>
</template>

<style>
html.dark {
  color-scheme: dark;
}
</style>
