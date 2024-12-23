<script lang="ts" setup>
import useHomePage from '@/composables/useHomePage.ts'

const {
  initializeHomePage,
} = useHomePage()

initializeHomePage()
</script>

<template>
<div class="flex flex-row w-full h-full">
  <div class="w-full glitch-wrapper">

  <div class="glitch-embed-wrap">
    <embed src="https://spiral-wool-angle.glitch.me" width="100%" height="100%"></embed>
  </div>
  </div>
</div>
</template>

<style scoped>
.glitch-wrapper {
  height: calc(100vh - 60px);
  overflow: hidden;
}
.glitch-embed-wrap {
  height: 100vh;
  width: 100vw;
}
</style>
